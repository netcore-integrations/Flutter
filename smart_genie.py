import sys
import subprocess
import os

# --- Ensure Python 3 is installed ---
def ensure_python3():
    # If running with Python 2, abort
    if sys.version_info < (3, 0):
        print("❌ Python 3 is required to run this script.")
        sys.exit(1)
    # Check if python3 is available (for subprocesses)
    try:
        subprocess.run(["python3", "--version"], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    except Exception:
        print("Python 3 is not installed or not available on PATH. Attempting to install via Homebrew...")
        # Check if Homebrew is installed
        try:
            subprocess.run(["brew", "--version"], check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        except Exception:
            print("Homebrew is not installed. Please install Homebrew first from https://brew.sh/")
            sys.exit(1)
        # Install python3
        result = subprocess.run(["brew", "install", "python"], check=False)
        if result.returncode != 0:
            print("❌ Failed to install Python 3 via Homebrew. Please install it manually and re-run the script.")
            sys.exit(1)
        print("✅ Python 3 installed successfully. Please re-run the script.")
        sys.exit(0)

ensure_python3()



import plistlib
import os
import glob
import sys
import re
import subprocess
import shutil

EXCLUDE_DIRS = ['/build/', '/Pods/', '/DerivedData/', '/.git/', '/Carthage/', '/Vendor/', '/Frameworks/']
DEFAULT_INDENT = "    "

# --- Markers ---
SMARTECH_DID_FINISH_LAUNCHING_MARKER_START = "// SMARTECH_INIT_BY_SCRIPT_START"
SMARTECH_DID_REGISTER_TOKEN_MARKER = "// SMARTECH_DID_REGISTER_TOKEN_BY_SCRIPT"
SMARTECH_DID_FAIL_REGISTER_MARKER = "// SMARTECH_DID_FAIL_REGISTER_BY_SCRIPT"
SMARTECH_WILL_PRESENT_MARKER = "// SMARTECH_WILL_PRESENT_BY_SCRIPT"
SMARTECH_DID_RECEIVE_MARKER = "// SMARTECH_DID_RECEIVE_BY_SCRIPT"
SMARTECH_OPEN_URL_MARKER_START = "// SMARTECH_OPEN_URL_BY_SCRIPT_START"
SMARTECH_OPEN_URL_MARKER_END = "// SMARTECH_OPEN_URL_BY_SCRIPT_END"
SMARTECH_DEEPLINK_HANDLER_MARKER = "// SMARTECH_DEEPLINK_HANDLER_BY_SCRIPT"
SMARTECH_UNCENTERDELEGATE_MARKER = "// SMARTECH_UNCENTERDELEGATE_BY_SCRIPT"

def fix_shellscript_arrays_in_pbxproj(pbxproj_path):
    if not os.path.isfile(pbxproj_path):
        print(f"❌ File not found: {pbxproj_path}")
        return

    with open(pbxproj_path, "r", encoding="utf-8") as f:
        content = f.read()

    # Improved: Remove empty/blank/extra comma lines from shellScript arrays
    def shellscript_array_to_string(match):
        lines = match.group(1).split('\n')
        # Only keep non-empty, non-comma, non-blank lines, strip quotes and commas
        script_lines = []
        for l in lines:
            l = l.strip().strip('"').strip(',')
            if l and l != ',':
                script_lines.append(l)
        return 'shellScript = "{}";'.format('\\n'.join(script_lines))

    new_content, count = re.subn(
        r'shellScript = \((.*?)\);',
        shellscript_array_to_string,
        content,
        flags=re.DOTALL
    )

    if count > 0:
        with open(pbxproj_path, "w", encoding="utf-8") as f:
            f.write(new_content)
        print(f"✅ Fixed {count} shellScript array(s) in {pbxproj_path}")
    else:
        print(f"ℹ️ No shellScript arrays found in {pbxproj_path}")

def find_xcodeproj_name(ios_project_path):
    for entry in os.listdir(ios_project_path):
        if entry.endswith('.xcodeproj') and os.path.isdir(os.path.join(ios_project_path, entry)):
            return entry
    return None

def filter_paths(paths, exclusions):
    valid_paths = []
    for p in paths:
        normalized_path = os.path.normpath(os.path.abspath(p))
        check_path = os.path.sep + normalized_path + os.path.sep
        is_excluded = False
        for exclude_pattern in exclusions:
            normalized_exclude = os.path.sep + exclude_pattern.strip(os.path.sep) + os.path.sep
            if normalized_exclude in check_path:
                is_excluded = True
                break
        if not is_excluded:
            valid_paths.append(p)
    return valid_paths

def find_info_plist(exclusions):
    print("\n--- Searching for Info.plist ---")
    try:
        all_plists = glob.glob('./**/Info.plist', recursive=True)
    except TypeError:
        print("Error: Recursive glob ('**/') requires Python 3.5 or newer.")
        return None
    if not all_plists:
        print("Error: No Info.plist found starting from the current directory.")
        return None
    valid_plists = filter_paths(all_plists, exclusions)
    if not valid_plists:
        print("Error: No Info.plist found after filtering excluded directories.")
        return None
    elif len(valid_plists) > 1:
        valid_plists.sort(key=len)
        likely_plist = valid_plists[0]
        print(f"  Using the shortest path found: {likely_plist}")
        return likely_plist
    else:
        found_path = valid_plists[0]
        print(f"Success: Found unique Info.plist at: {found_path}")
        return found_path

def find_app_delegate_details(exclusions):
    print("\n--- Searching for App Entry Point (AppDelegate/SwiftUI App) ---")
    app_delegate_info = None
    try:
        swift_delegate_files = filter_paths(glob.glob('./ios/**/AppDelegate.swift', recursive=True), exclusions)
        objc_delegate_files = filter_paths(glob.glob('./ios/**/AppDelegate.m', recursive=True), exclusions)
        potential_delegates = []
        if swift_delegate_files:
            potential_delegates.extend([{'path': p, 'name': 'AppDelegate', 'language': 'swift'} for p in swift_delegate_files])
        if objc_delegate_files:
            potential_delegates.extend([{'path': p, 'name': 'AppDelegate', 'language': 'objc'} for p in objc_delegate_files])
        if len(potential_delegates) == 1:
            app_delegate_info = potential_delegates[0]
        elif len(potential_delegates) > 1:
            swift_appdelegate = next((d for d in potential_delegates if d['language'] == 'swift'), None)
            if swift_appdelegate:
                app_delegate_info = swift_appdelegate
            else:
                potential_delegates.sort(key=lambda d: len(d['path']))
                app_delegate_info = potential_delegates[0]
    except TypeError:
        print("Error: Recursive glob ('**/') requires Python 3.5 or newer for AppDelegate search.")
        return {'error': "Python 3.5+ Required"}
    if not app_delegate_info:
        try:
            swift_files = filter_paths(glob.glob('./ios/**/*.swift', recursive=True), exclusions)
            swiftui_app_regex = re.compile(r"@main\s+(?:public\s+)?struct\s+([\w]+)\s*:\s*App")
            for file_path in swift_files:
                try:
                    with open(file_path, 'r', encoding='utf-8') as f: content = f.read()
                    match = swiftui_app_regex.search(content)
                    if match:
                        app_delegate_info = {'path': file_path, 'name': match.group(1), 'language': 'swiftui_app'}
                        break
                except Exception: pass
        except Exception as e: print(f"Warning: Error during SwiftUI App search: {e}")
    if not app_delegate_info:
        print("Warning: Could not automatically find a conventional AppDelegate (Swift/ObjC) or a SwiftUI App struct.")
        return None
    return app_delegate_info

def get_bool_input(prompt_message):
    while True:
        response = input(f"{prompt_message} (y/n): ").strip().lower()
        if response in ['y', 'yes']: return True
        if response in ['n', 'no']: return False
        print("Invalid input. Please enter 'y' or 'n'.")

def get_smartech_keys_from_user():
    print("\n--- Enter Smartech Configuration ---")
    smartech_dict = {}
    try:
        while not smartech_dict.get('SmartechAppGroup'):
            smartech_dict['SmartechAppGroup'] = input("Enter Smartech App Group (e.g., group.com.yourcompany.app): ").strip()
            if not smartech_dict['SmartechAppGroup']: print("  App Group cannot be empty.")
        while not smartech_dict.get('SmartechAppId'):
            smartech_dict['SmartechAppId'] = input("Enter Smartech App ID: ").strip()
            if not smartech_dict['SmartechAppId']: print("  App ID cannot be empty.")
        smartech_dict['SmartechAutoFetchLocation'] = get_bool_input("Enable Smartech Auto Fetch Location?")
        smartech_dict['SmartechUseAdvId'] = get_bool_input("Enable Smartech Use Advertising ID (IDFA)?")
        print("Smartech configuration collected.")
        return smartech_dict
    except (EOFError, KeyboardInterrupt):
        print("\nInput cancelled. Smartech configuration skipped.")
        return None

def get_hansel_keys_from_user():
    print("\n--- Hansel SDK Configuration ---")
    user_opts_for_hansel = get_bool_input("Do you use Hansel SDK?")
    if not user_opts_for_hansel:
        print("Hansel SDK configuration will be skipped.")
        return None, False
    hansel_dict = {}
    try:
        while not hansel_dict.get('HanselAppId'):
            hansel_dict['HanselAppId'] = input("Enter Hansel App ID: ").strip()
            if not hansel_dict['HanselAppId']: print("  Hansel App ID cannot be empty.")
        while not hansel_dict.get('HanselAppKey'):
            hansel_dict['HanselAppKey'] = input("Enter Hansel App Key: ").strip()
            if not hansel_dict['HanselAppKey']: print("  Hansel App Key cannot be empty.")
        print("Hansel SDK configuration collected.")
        return hansel_dict, True
    except (EOFError, KeyboardInterrupt):
        print("\nInput cancelled. Hansel configuration skipped.")
        return None, True

def get_indentation(line_content):
    match = re.match(r"^(\s*)", line_content)
    return match.group(1) if match else ""

def check_marker_within_bounds(lines, marker, start_idx, end_idx):
    if start_idx < 0 or end_idx < 0 or start_idx > end_idx: return False
    for i in range(start_idx, end_idx + 1):
        if marker in lines[i]: return True
    return False

def find_class_definition_line(lines, language, class_name="AppDelegate"):
    swift_class_pattern = re.compile(rf"^\s*(?:@\w+\s*)*\s*(?:(?:private|internal|public|open)\s+)?class\s+{class_name}\s*[:{{]")
    objc_interface_pattern = re.compile(rf"^\s*@interface\s+{class_name}\s*[:{{]")
    objc_implementation_pattern = re.compile(rf"^\s*@implementation\s+{class_name}")
    interface_idx, implementation_idx = -1, -1
    for i, line in enumerate(lines):
        if language == 'swift' and swift_class_pattern.search(line): return i
        elif language == 'objc':
            if interface_idx == -1 and objc_interface_pattern.search(line): interface_idx = i
            if implementation_idx == -1 and objc_implementation_pattern.search(line):
                implementation_idx = i; return implementation_idx
    return interface_idx if language == 'objc' and interface_idx != -1 else -1

def find_method_bounds(lines, language, signature_patterns, start_search_line=0):
    for i in range(start_search_line, len(lines)):
        current_line_content = lines[i]
        if current_line_content.strip().startswith("//"):
            continue
        for pattern in signature_patterns:
            if pattern.search(current_line_content):
                signature_line_idx = i
                opening_brace_line_idx = -1
                brace_level = 0
                for j in range(signature_line_idx, len(lines)):
                    line_for_brace = lines[j]
                    if '{' in line_for_brace:
                        opening_brace_line_idx = j
                        for k in range(opening_brace_line_idx, len(lines)):
                            line_for_body = lines[k]
                            clean_line_for_body = re.sub(r"//.*", "", line_for_body)
                            brace_level += clean_line_for_body.count('{')
                            brace_level -= clean_line_for_body.count('}')
                            if brace_level == 0 and k >= opening_brace_line_idx:
                                return signature_line_idx, opening_brace_line_idx, k
                        return signature_line_idx, opening_brace_line_idx, -1
                    elif j > signature_line_idx + 5:
                        break
                return signature_line_idx, -1, -1
    return -1, -1, -1

def add_uncenterdelegate_if_needed(lines, language, class_name="AppDelegate"):
    print(f"   Checking for UNUserNotificationCenterDelegate conformance...")
    class_def_line_idx = find_class_definition_line(lines, language, class_name)
    if class_def_line_idx == -1:
        print(f"      Error: Could not find class definition for '{class_name}'. Skipping delegate check.")
        return lines, False
    class_line_content = lines[class_def_line_idx]
    if "UNUserNotificationCenterDelegate" in class_line_content:
        print(f"      UNUserNotificationCenterDelegate conformance already exists.")
        return lines, False
    modified = False
    if language == 'swift':
        parts = class_line_content.split('{', 1)
        class_header = parts[0].rstrip()
        body_start = " {" + parts[1] if len(parts) > 1 else " {"
        if ':' in class_header:
            lines[class_def_line_idx] = f"{class_header}, UNUserNotificationCenterDelegate{body_start}"
            modified = True
        else:
            lines[class_def_line_idx] = f"{class_header}: UNUserNotificationCenterDelegate{body_start}"
            modified = True
    elif language == 'objc':
        interface_match = re.match(r"(\s*@interface\s+\w+\s*:\s*\w+\s*)(<[^>]*>)?(.*)", class_line_content)
        if interface_match:
            prefix, protocols_group, suffix = interface_match.groups()
            new_protocols = "UNUserNotificationCenterDelegate"
            if protocols_group:
                new_protocols = f"{protocols_group[1:-1]}, {new_protocols}"
            lines[class_def_line_idx] = f"{prefix}<{new_protocols}>{suffix}\n"
            modified = True
    if modified:
        print(f"      Added UNUserNotificationCenterDelegate conformance.")
        indent_for_marker = get_indentation(lines[class_def_line_idx+1] if class_def_line_idx+1 < len(lines) else lines[class_def_line_idx]) + DEFAULT_INDENT
        lines.insert(class_def_line_idx + 1, f"{indent_for_marker}{SMARTECH_UNCENTERDELEGATE_MARKER}\n")
        return lines, True
    else:
        print(f"      Could not automatically add UNUserNotificationCenterDelegate conformance.")
        return lines, False

def add_or_update_method(lines, language, config):
    method_name = config['name']
    swift_patterns = [re.compile(p) for p in config.get('swift_patterns', [])]
    objc_patterns = [re.compile(p) for p in config.get('objc_patterns', [])]
    code_to_insert_raw = config['code'].get(language, [])
    code_to_insert = [line for line in code_to_insert_raw if line is not None]
    marker = config['marker']
    add_if_missing = config.get('add_if_missing', True)
    swift_stub = config.get('swift_stub', [])
    objc_stub = config.get('objc_stub', [])
    patterns = swift_patterns if language == 'swift' else objc_patterns
    sig_idx, open_brace_idx, end_idx = find_method_bounds(lines, language, patterns)

    # If method exists
    if sig_idx != -1 and open_brace_idx != -1 and end_idx != -1:
        method_body_lines = lines[open_brace_idx+1:end_idx]
        method_body = ''.join(method_body_lines).strip()
        inserted = False
        # Find indentation for the method body
        body_indent = None
        for idx in range(open_brace_idx+1, end_idx):
            if lines[idx].strip():
                body_indent = get_indentation(lines[idx])
                break
        if body_indent is None:
            body_indent = get_indentation(lines[sig_idx]) + DEFAULT_INDENT

        # Special handling for openURL
        if method_name == 'openURL':
            smartech_code = [
                f"{body_indent}let handleBySmartech:Bool = Smartech.sharedInstance().application(app, open: url, options: options);",
                f"{body_indent}if(!handleBySmartech) {{"
            ]
            end_if = f"{body_indent}}}"
            return_true = f"{body_indent}return true;"
            if not method_body:
                new_body = smartech_code + [
                    f"{body_indent}    // handle the url by the app",
                    end_if,
                    return_true
                ]
            else:
                moved_code = []
                for line in method_body_lines:
                    content = line.rstrip('\n')
                    if content.strip() != "":
                        moved_code.append(body_indent + DEFAULT_INDENT + content.strip())
                new_body = smartech_code + moved_code + [end_if, return_true]
            lines[open_brace_idx+1:end_idx] = [line + "\n" for line in new_body]
            return lines, True

        # For other methods, insert code if not present
        for line in code_to_insert:
            if line.strip() and line.strip() not in method_body:
                lines.insert(open_brace_idx+1, f"{body_indent}{line}\n")
                inserted = True
        return lines, inserted

    # If method is missing, add the whole method with correct code and indentation
    elif add_if_missing:
        class_def_line_idx = find_class_definition_line(lines, language)
        if class_def_line_idx == -1:
            print(f"      Error: Cannot find class definition for adding method '{method_name}'. Skipping.")
            return lines, False
        # Find the last closing brace after the class definition (assume it's the class end)
        class_end_brace_idx = -1
        brace_level = 0
        for i in range(class_def_line_idx, len(lines)):
            line_content = lines[i]
            brace_level += line_content.count('{')
            brace_level -= line_content.count('}')
            if brace_level == 0 and '{' in ''.join(lines[class_def_line_idx:i+1]):
                class_end_brace_idx = i
                break
        if class_end_brace_idx != -1:
            indent_for_new_method = get_indentation(lines[class_def_line_idx]) + DEFAULT_INDENT
            # Custom stubs for special methods
            if method_name == 'openURL':
                stub = [
                    "override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {",
                    f"{indent_for_new_method}let handleBySmartech:Bool = Smartech.sharedInstance().application(app, open: url, options: options);",
                    f"{indent_for_new_method}if(!handleBySmartech) {{",
                    f"{indent_for_new_method}{DEFAULT_INDENT}// handle the url by the app",
                    f"{indent_for_new_method}}}",
                    f"{indent_for_new_method}return true;",
                    "}"
                ]
            elif method_name == 'willPresent':
                stub = [
                    "override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {",
                    f"{indent_for_new_method}SmartPush.sharedInstance().willPresentForegroundNotification(notification)",
                    f"{indent_for_new_method}completionHandler([.alert, .badge, .sound])",
                    "}"
                ]
            elif method_name == 'didReceive':
                stub = [
                    "override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {",
                    f"{indent_for_new_method}SmartPush.sharedInstance().didReceive(response)",
                    f"{indent_for_new_method}completionHandler()",
                    "}"
                ]
            elif method_name == 'didRegisterForRemoteNotificationsWithDeviceToken':
                stub = [
                    "override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {",
                    f"{indent_for_new_method}SmartPush.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)",
                    "}"
                ]
            elif method_name == 'didFailToRegisterForRemoteNotificationsWithError':
                stub = [
                    "override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {",
                    f"{indent_for_new_method}SmartPush.sharedInstance().didFailToRegisterForRemoteNotificationsWithError(error)",
                    f"{indent_for_new_method}print(\"Failed to register for remote notifications: \\(error.localizedDescription)\")",
                    "}"
                ]
            else:
                stub = swift_stub if language == 'swift' else objc_stub
                if not stub:
                    print(f"      Error: No method stub defined for {method_name} in {language}. Cannot add method.")
                    return lines, False
            stub_to_insert = ["\n"] + [f"{indent_for_new_method}{line}\n" if i != 0 and i != len(stub)-1 else f"{line}\n" for i, line in enumerate(stub)]
            lines = lines[:class_end_brace_idx] + stub_to_insert + lines[class_end_brace_idx:]
            print(f"      Successfully added method '{method_name}'.")
            return lines, True
    return lines, False

def modify_app_delegate(app_delegate_file_path, language, add_hansel_code_flag, use_override=False):
    print(f"\n--- Modifying AppDelegate: {app_delegate_file_path} ({language}) ---")
    print("🚨 IMPORTANT: Review changes carefully after the script finishes! 🚨")
    backup_ad_path = app_delegate_file_path + '.backup'
    try:
        print(f"Backing up AppDelegate to {backup_ad_path}")
        os.makedirs(os.path.dirname(backup_ad_path), exist_ok=True)
        with open(app_delegate_file_path, 'r', encoding='utf-8') as f_read, \
             open(backup_ad_path, 'w', encoding='utf-8') as f_write:
            f_write.write(f_read.read())
    except Exception as e:
        print(f"Error backing up AppDelegate: {e}. Skipping modification.")
        return False
    overall_success = True
    made_changes = False
    lines = []
    try:
        with open(app_delegate_file_path, 'r', encoding='utf-8') as file:
            lines = file.readlines()
        methods_to_process = [
        {
            'name': 'didFinishLaunchingWithOptions',
            'swift_patterns': [
                r"func\s+application\s*\(\s*_?\s*application:\s*UIApplication\s*,\s*didFinishLaunchingWithOptions\s*:\s*\[?\w*\.?LaunchOptionsKey:?.*\]?\s*\??\)",
                r"func\s+application\s*\(.*didFinishLaunchingWithOptions.*\)",
                r"(?:override\s+)?func\s+(?:application|_)\s*\(.*didFinishLaunchingWithOptions"
            ],
            'objc_patterns': [
                r"-\s*\(BOOL\)\s*application:\s*\(UIApplication\s*\*\)\s*\w+\s*didFinishLaunchingWithOptions:\s*\(NSDictionary\s*\*\)\s*\w+"
            ],
            'code': {
                'swift': [
                    "Hansel.enableDebugLogs() // TODO: Disable debug logs for production" if add_hansel_code_flag else None,
                    "Smartech.sharedInstance().trackAppInstallUpdateBySmartech()",
                    "Smartech.sharedInstance().setDebugLevel(.verbose) // TODO: Set appropriate debug level",
                    "SmartPush.sharedInstance().registerForPushNotificationWithDefaultAuthorizationOptions()",
                    "UNUserNotificationCenter.current().delegate = self",
                    "Smartech.sharedInstance().initSDK(with: self, withLaunchOptions: launchOptions)",
                ],
                'objc': [
                    "[Hansel enableDebugLogs];" if add_hansel_code_flag else None,
                    "[[Smartech sharedInstance] trackAppInstallUpdateBySmartech];",
                    "[[Smartech sharedInstance] setDebugLevel:SmartechLogLevelVerbose];",
                    "[[SmartPush sharedInstance] registerForPushNotificationWithDefaultAuthorizationOptions];",
                    "[UNUserNotificationCenter currentNotificationCenter].delegate = self;",
                    "[[Smartech sharedInstance] initSDKWithApplication:self didFinishLaunchingWithOptions:launchOptions];",
                ]
                },
            'marker': SMARTECH_DID_FINISH_LAUNCHING_MARKER_START,
            'insertion_logic': 'after_brace', 'add_if_missing': False,
        },
        {
            'name': 'didRegisterForRemoteNotificationsWithDeviceToken',
            'swift_patterns': [
                r"(?:override\s+)?func\s+application\s*\(\s*_?\s*application:\s*UIApplication\s*,\s*didRegisterForRemoteNotificationsWithDeviceToken\s*deviceToken:\s*Data\s*\)",
                r"(?:override\s+)?func\s+application\s*\(\s*.*didRegisterForRemoteNotificationsWithDeviceToken.*"
            ],
            'objc_patterns': [
                r"-\s*\(.*didRegisterForRemoteNotificationsWithDeviceToken\s*:\s*NSData"
            ],
            'code': {'swift': ["SmartPush.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)"],
                        'objc': ["[[SmartPush sharedInstance] didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];"]},
            'marker': SMARTECH_DID_REGISTER_TOKEN_MARKER, 'insertion_logic': 'after_brace', 'add_if_missing': True,
            'swift_stub': [f"{'override ' if use_override else ''}func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {{",
                            f"{DEFAULT_INDENT}// {SMARTECH_DID_REGISTER_TOKEN_MARKER}",
                            f"{DEFAULT_INDENT}SmartPush.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)", "}"],
                'objc_stub': ["- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {",
                            f"{DEFAULT_INDENT}// {SMARTECH_DID_REGISTER_TOKEN_MARKER}",
                            f"{DEFAULT_INDENT}[[SmartPush sharedInstance] didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];", "}"]
        },
        {
            'name': 'didFailToRegisterForRemoteNotificationsWithError',
            'swift_patterns': [
                r"(?:override\s+)?func\s+application\s*\(\s*_?\s*application:\s*UIApplication\s*,\s*didFailToRegisterForRemoteNotificationsWithError\s*error:\s*Error\s*\)",
                r"(?:override\s+)?func\s+application\s*\(\s*.*didFailToRegisterForRemoteNotificationsWithError.*"
            ],
            'objc_patterns': [
                r"-\s*\(.*didFailToRegisterForRemoteNotificationsWithError\s*:\s*NSError"
            ],
            'code': {'swift': ["SmartPush.sharedInstance().didFailToRegisterForRemoteNotificationsWithError(error)"],
                        'objc': ["[[SmartPush sharedInstance] didFailToRegisterForRemoteNotificationsWithError:error];"]},
            'marker': SMARTECH_DID_FAIL_REGISTER_MARKER, 'insertion_logic': 'after_brace', 'add_if_missing': True,
            'swift_stub': [f"{'override ' if use_override else ''}func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {{",
                            f"{DEFAULT_INDENT}// {SMARTECH_DID_FAIL_REGISTER_MARKER}",
                            f"{DEFAULT_INDENT}SmartPush.sharedInstance().didFailToRegisterForRemoteNotificationsWithError(error)",
                            f"{DEFAULT_INDENT}print(\"Failed to register for remote notifications: \\(error.localizedDescription)\")", "}"],
            'objc_stub': ["- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {",
                            f"{DEFAULT_INDENT}// {SMARTECH_DID_FAIL_REGISTER_MARKER}",
                            f"{DEFAULT_INDENT}[[SmartPush sharedInstance] didFailToRegisterForRemoteNotificationsWithError:error];",
                            f"{DEFAULT_INDENT}NSLog(@\"Failed to register for remote notifications: %@\", error.localizedDescription);", "}"]
        },
        {
            'name': 'willPresent',
            'swift_patterns': [
                r"(?:override\s+)?func\s+userNotificationCenter\s*\(\s*_?\s*center:\s*UNUserNotificationCenter\s*,\s*willPresent\s*notification:\s*UNNotification.*",
                r"func\s+userNotificationCenter\s*\(.*willPresent.*"
            ],
            'objc_patterns': [],
            'code': {'swift': [
                "SmartPush.sharedInstance().willPresentForegroundNotification(notification)"
            ]},
            'marker': SMARTECH_WILL_PRESENT_MARKER, 'insertion_logic': 'after_brace', 'add_if_missing': True,
            'swift_stub': [f"{'override ' if use_override else ''}func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {{",
                            f"{DEFAULT_INDENT}SmartPush.sharedInstance().willPresentForegroundNotification(notification)",
                            f"{DEFAULT_INDENT}completionHandler([.alert, .badge, .sound])", "}"],
            'objc_stub': []
        },
        {
            'name': 'didReceive',
            'swift_patterns': [
                r"(?:override\s+)?func\s+userNotificationCenter\s*\(\s*_?\s*center:\s*UNUserNotificationCenter\s*,\s*didReceive\s*response:\s*UNNotificationResponse.*",
                r"func\s+userNotificationCenter\s*\(.*didReceive.*"
            ],
            'objc_patterns': [],
            'code': {'swift': [
                "SmartPush.sharedInstance().didReceive(response)"
            ]},
            'marker': SMARTECH_DID_RECEIVE_MARKER, 'insertion_logic': 'after_brace', 'add_if_missing': True,
            'swift_stub': [f"{'override ' if use_override else ''}func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {{",
                            f"{DEFAULT_INDENT}SmartPush.sharedInstance().didReceive(response)",
                            f"{DEFAULT_INDENT}completionHandler()", "}"],
            'objc_stub': []
        },
        {
            'name': 'openURL',
            'swift_patterns': [
                r"(?:override\s+)?func\s+application\s*\(\s*_?\s*app:\s*UIApplication\s*,\s*open\s+url:\s*URL.*",
                r"func\s+application\s*\(.*open\s+url:.*"
            ],
            'objc_patterns': [],
            'code': {'swift': [
                "let handleBySmartech:Bool = Smartech.sharedInstance().application(app, open: url, options: options);",
                "if(!handleBySmartech) {",
                "    // handle the url by the app",
                "}",
                "return true;"
            ]},
            'marker': SMARTECH_OPEN_URL_MARKER_START, 'insertion_logic': 'after_brace', 'add_if_missing': True,
            'swift_stub': [f"{'override ' if use_override else ''}func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {{",
                            f"{DEFAULT_INDENT}let handleBySmartech:Bool = Smartech.sharedInstance().application(app, open: url, options: options);",
                            f"{DEFAULT_INDENT}if(!handleBySmartech) {{",
                            f"{DEFAULT_INDENT}{DEFAULT_INDENT}// handle the url by the app",
                            f"{DEFAULT_INDENT}}}",
                            f"{DEFAULT_INDENT}return true;", "}"],
            'objc_stub': []
        },
    ]
        # Add or update methods
        for method_config in methods_to_process:
            lines, modified = add_or_update_method(lines, language, method_config)
        # Check for handleDeeplinkAction
        deeplink_pattern = re.compile(r"func\s+handleDeeplinkAction\s*\(")
        if not any(deeplink_pattern.search(line) for line in lines):
            # Insert before last closing brace of class
            class_end = len(lines) - 1
            for i in range(len(lines) - 1, -1, -1):
                if lines[i].strip() == "}":
                    class_end = i
                    break
            stub = [
                "func handleDeeplinkAction(withURLString deeplinkURLString: String, andNotificationPayload notificationPayload: [AnyHashable : Any]?) {",
                "    NSLog(\"SMTL deeplink Native---> \\(deeplinkURLString)\")",
                "    SmartechBasePlugin.handleDeeplinkAction(deeplinkURLString, andCustomPayload: notificationPayload)",
                "}"
            ]
            lines = lines[:class_end] + [f"{DEFAULT_INDENT}{l}\n" for l in stub] + lines[class_end:]
            print("Added handleDeeplinkAction method.")
        # Write back
        with open(app_delegate_file_path, 'w', encoding='utf-8') as file:
            file.writelines(lines)
        print(f"   Successfully modified AppDelegate.")
        return True
    except Exception as e:
        print(f"Error modifying AppDelegate: {e}")
        return False

#
# ==============================================================================
# == STEP 1: Replace this entire function in your smart_genie.py file ==
# ==============================================================================
#
def create_smartech_extensions(smartech_app_group, smartech_app_id, ios_project_path):
    print("\n--- Creating Smartech Extension Files ---")
    
    # --- SmartechNCE (Notification Content Extension) ---
    nce_path = os.path.join(ios_project_path, "SmartechNCE")
    os.makedirs(nce_path, exist_ok=True)
    
    nce_info = {
        "CFBundleIdentifier": "$(PRODUCT_BUNDLE_IDENTIFIER)", "CFBundleName": "$(PRODUCT_NAME)",
        "CFBundleDevelopmentRegion": "$(DEVELOPMENT_LANGUAGE)", "CFBundleDisplayName": "SmartechNCE",
        "CFBundlePackageType": "$(PRODUCT_BUNDLE_PACKAGE_TYPE)", "CFBundleShortVersionString": "$(MARKETING_VERSION)",
        "CFBundleVersion": "$(CURRENT_PROJECT_VERSION)", "NSExtension": {
            "NSExtensionPointIdentifier": "com.apple.usernotifications.content-extension",
            "NSExtensionMainStoryboard": "MainInterface", "NSExtensionAttributes": {
                "UNNotificationExtensionCategory": ["SmartechCarouselLandscapeNotification", "SmartechCarouselPortraitNotification", "SmartechPN"],
                "UNNotificationExtensionDefaultContentHidden": True, "UNNotificationExtensionUserInteractionEnabled": True,
                "UNNotificationExtensionInitialContentSizeRatio": 0.25,
            },
        },
        "SmartechKeys": {"SmartechAppGroup": smartech_app_group, "SmartechNotificationIcon": "MyAppIcon"}
    }
    with open(os.path.join(nce_path, "Info.plist"), "wb") as f:
        plistlib.dump(nce_info, f)

    # **FIXED**: Updated NotificationViewController.swift with the correct outlet property.
    with open(os.path.join(nce_path, "NotificationViewController.swift"), "w") as f:
        f.write("""import UIKit
import SmartPush

class NotificationViewController: SMTCustomNotificationViewController {

    @IBOutlet var customPNView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.customView = customPNView
    }
}
""")

    with open(os.path.join(nce_path, "SmartechNCE.entitlements"), "w") as f:
        f.write(f'<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"><plist version="1.0"><dict><key>com.apple.security.application-groups</key><array><string>{smartech_app_group}</string></array></dict></plist>')

    # **FIXED**: Using the exact storyboard content you provided.
    with open(os.path.join(nce_path, "MainInterface.storyboard"), "w") as f:
        f.write("""<?xml version="1.0" encoding="UTF-8"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="32700.99.1234" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES" initialViewController="M4Y-Lb-cyx">
    <device id="retina6_12" orientation="portrait" appearance="light"/>
    <dependencies>
        <deployment identifier="iOS"/>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="22685"/>
        <capability name="Safe area layout guides" minToolsVersion="9.0"/>
        <capability name="System colors in document resources" minToolsVersion="11.0"/>
        <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
    </dependencies>
    <scenes>
        <!--Notification View Controller-->
        <scene sceneID="cwh-vc-ff4">
            <objects>
                <viewController id="M4Y-Lb-cyx" userLabel="Notification View Controller" customClass="NotificationViewController" customModule="SmartechNCE" customModuleProvider="target" sceneMemberID="viewController">
                    <view key="view" contentMode="scaleToFill" simulatedAppContext="notificationCenter" id="S3S-Oj-5AN">
                        <rect key="frame" x="0.0" y="0.0" width="320" height="280"/>
                        <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
                        <subviews>
                            <view contentMode="scaleToFill" translatesAutoresizingMaskIntoConstraints="NO" id="fSf-5c-Mrw">
                                <rect key="frame" x="0.0" y="0.0" width="320" height="280"/>
                                <color key="backgroundColor" systemColor="systemBackgroundColor"/>
                            </view>
                        </subviews>
                        <viewLayoutGuide key="safeArea" id="2BE-c3-nQJ"/>
                        <color key="backgroundColor" red="0.45882353186607361" green="0.74901962280273438" blue="0.66666668653488159" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
                        <constraints>
                            <constraint firstAttribute="bottom" secondItem="fSf-5c-Mrw" secondAttribute="bottom" id="LcT-GD-eXn"/>
                            <constraint firstItem="fSf-5c-Mrw" firstAttribute="trailing" secondItem="2BE-c3-nQJ" secondAttribute="trailing" id="RA7-fH-OHq"/>
                            <constraint firstItem="fSf-5c-Mrw" firstAttribute="leading" secondItem="2BE-c3-nQJ" secondAttribute="leading" id="SO1-TG-ekj"/>
                            <constraint firstItem="fSf-5c-Mrw" firstAttribute="top" secondItem="S3S-Oj-5AN" secondAttribute="top" id="lGo-3c-kNS"/>
                        </constraints>
                    </view>
                    <extendedEdge key="edgesForExtendedLayout"/>
                    <freeformSimulatedSizeMetrics key="simulatedDestinationMetrics"/>
                    <size key="freeformSize" width="320" height="280"/>
                    <connections>
                        <outlet property="customPNView" destination="fSf-5c-Mrw" id="liy-h9-rjU"/>
                    </connections>
                </viewController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="vXp-U4-Rya" userLabel="First Responder" sceneMemberID="firstResponder"/>
            </objects>
            <point key="canvasLocation" x="71.755725190839698" y="-2.1126760563380285"/>
        </scene>
    </scenes>
    <resources>
        <systemColor name="systemBackgroundColor">
            <color white="1" alpha="1" colorSpace="custom" customColorSpace="genericGamma22GrayColorSpace"/>
        </systemColor>
    </resources>
</document>
""")
    
    nce_assets_path = os.path.join(nce_path, "Media.xcassets")
    os.makedirs(os.path.join(nce_assets_path, "MyAppIcon.imageset"), exist_ok=True)
    with open(os.path.join(nce_assets_path, "Contents.json"), "w") as f:
        f.write('{"info" : {"author" : "xcode","version" : 1}}')
    with open(os.path.join(nce_assets_path, "MyAppIcon.imageset", "Contents.json"), "w") as f:
        f.write('{"images" : [], "info" : {"author" : "xcode","version" : 1}}')

    # --- SmartechNSE (Notification Service Extension) ---
    nse_path = os.path.join(ios_project_path, "SmartechNSE")
    os.makedirs(nse_path, exist_ok=True)
    
    nse_info = {
        "CFBundleIdentifier": "$(PRODUCT_BUNDLE_IDENTIFIER)", "CFBundleName": "$(PRODUCT_NAME)",
        "CFBundleDevelopmentRegion": "$(DEVELOPMENT_LANGUAGE)", "CFBundleDisplayName": "SmartechNSE",
        "CFBundlePackageType": "$(PRODUCT_BUNDLE_PACKAGE_TYPE)", "CFBundleShortVersionString": "$(MARKETING_VERSION)",
        "CFBundleVersion": "$(CURRENT_PROJECT_VERSION)", "NSExtension": {
            "NSExtensionPointIdentifier": "com.apple.usernotifications.service",
            "NSExtensionPrincipalClass": "$(PRODUCT_MODULE_NAME).NotificationService"
        },
        "SmartechKeys": {"SmartechAppId": smartech_app_id, "SmartechAppGroup": smartech_app_group}
    }
    with open(os.path.join(nse_path, "Info.plist"), "wb") as f:
        plistlib.dump(nse_info, f)

    with open(os.path.join(nse_path, "NotificationService.swift"), "w") as f:
        f.write("""import UserNotifications
import SmartPush

class NotificationService: UNNotificationServiceExtension {
  
  let smartechServiceExtension = SMTNotificationServiceExtension()
  
  override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
    if SmartPush.sharedInstance().isNotification(fromSmartech:request.content.userInfo){
      smartechServiceExtension.didReceive(request, withContentHandler: contentHandler)
    } else {
      contentHandler(request.content)
    }
  }
  
  override func serviceExtensionTimeWillExpire() {
    smartechServiceExtension.serviceExtensionTimeWillExpire()
  }
}
""")

    with open(os.path.join(nse_path, "SmartechNSE.entitlements"), "w") as f:
        f.write(f'<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"><plist version="1.0"><dict><key>com.apple.security.application-groups</key><array><string>{smartech_app_group}</string></array></dict></plist>')
    print("✅ SmartechNCE and SmartechNSE extension files created successfully.")


def write_ensure_capabilities_ruby_script(script_path):
    ruby_code = """
require 'xcodeproj'
require 'plist'

def ensure_entitlements_file(target, project_dir)
  entitlements_path = nil
  target.build_configurations.each do |config|
    entitlements = config.build_settings['CODE_SIGN_ENTITLEMENTS']
    if entitlements
      entitlements_path = File.join(project_dir, entitlements)
      break
    end
  end
  unless entitlements_path
    entitlements_path = File.join(project_dir, "App.entitlements")
    target.build_configurations.each do |config|
      config.build_settings['CODE_SIGN_ENTITLEMENTS'] = File.basename(entitlements_path)
    end
    puts "Created entitlements file: #{entitlements_path}"
  end
  entitlements_path
end

def ensure_capabilities(xcodeproj_path, app_group_id)
  project = Xcodeproj::Project.open(xcodeproj_path)
  main_target = project.targets.find { |t| t.symbol_type == :application }
  unless main_target
    puts "❌ Could not find main app target."
    exit 1
  end

  project_dir = File.dirname(xcodeproj_path)
  entitlements_path = ensure_entitlements_file(main_target, project_dir)

  entitlements = File.exist?(entitlements_path) ? Plist.parse_xml(entitlements_path) : {}

  # App Groups
  app_groups = entitlements["com.apple.security.application-groups"] || []
  unless app_groups.include?(app_group_id)
    app_groups << app_group_id
    entitlements["com.apple.security.application-groups"] = app_groups
    puts "✅ Added App Group '#{app_group_id}' to entitlements."
  end

  # Save entitlements
  File.open(entitlements_path, "wb") { |f| f.write(entitlements.to_plist) }

  # Push Notifications: No entitlements key needed, just a reminder
  puts "✅ Ensure Push Notifications capability is enabled in Xcode (no entitlements key needed)."

  project.save
end

if ARGV.length < 2
  puts "Usage: ruby ensure_capabilities.rb <xcodeproj_path> <app_group_id>"
  exit 1
end

xcodeproj_path = ARGV[0]
app_group_id = ARGV[1]

ensure_capabilities(xcodeproj_path, app_group_id)
"""
    with open(script_path, "w") as f:
        f.write(ruby_code)

def write_ruby_add_target_script(script_path):
    # This is a merged and improved script.
    # It combines the successful target creation logic from your script (which provides the correct icons and tabs)
    # with the detailed build settings and file handling from the previous version (which ensures 'pod install' works).
    ruby_code = r"""
require 'xcodeproj'
require 'pathname'

# This function embeds the created extension within the main application target.
# This is crucial for the app to find and use the extension.
def embed_extension_in_main_target(project, extension_target)
  main_target = project.targets.find { |t| t.symbol_type == :application }
  unless main_target
    puts "⚠️  Could not find main app target to embed extension."
    return
  end
  main_target.add_dependency(extension_target)
  
  embed_phase = main_target.copy_files_build_phases.find { |p| p.dst_subfolder_spec == '13' } # 13 = PlugIns
  unless embed_phase
    embed_phase = main_target.new_copy_files_build_phase('Embed App Extensions')
    embed_phase.dst_subfolder_spec = '13'
  end
  
  appex_ref = extension_target.product_reference
  unless embed_phase.files_references.include?(appex_ref)
    build_file = embed_phase.add_file_reference(appex_ref, true)
    build_file.settings = { 'ATTRIBUTES' => ['CodeSignOnCopy', 'RemoveHeadersOnCopy'] }
    puts "✅ Embedded #{extension_target.name} into main target '#{main_target.name}'."
  else
    puts "ℹ️  #{extension_target.name} already embedded in main target."
  end
end


def add_extension_target(project_path, target_name, product_type, info_plist, entitlements, source_files, resource_files)
  project = Xcodeproj::Project.open(project_path)
  
  if project.targets.any? { |t| t.name == target_name }
      puts "ℹ️  Target '#{target_name}' already exists. Skipping creation."
      return
  end

  puts "Creating new target '#{target_name}'..."
  target = project.new_target(:app_extension, target_name, :ios, '13.0')
  target.product_type = product_type

  # --- Merged Logic ---
  # 1. Using the robust build settings required for CocoaPods.
  # 2. Using your successful logic for deriving the bundle identifier.
  main_target = project.targets.find { |t| t.symbol_type == :application }
  main_bundle_id = main_target.build_configurations[0].build_settings['PRODUCT_BUNDLE_IDENTIFIER']

  target.build_configurations.each do |config|
    config.build_settings.merge!({
        'INFOPLIST_FILE' => info_plist,
        'PRODUCT_NAME' => "$(TARGET_NAME)",
        'SWIFT_VERSION' => '5.0',
        'IPHONEOS_DEPLOYMENT_TARGET' => '13.0',
        'TARGETED_DEVICE_FAMILY' => '1,2',
        'CODE_SIGN_STYLE' => 'Automatic',
        'LD_RUNPATH_SEARCH_PATHS' => '$(inherited) @executable_path/Frameworks @executable_path/../../Frameworks',
    })
    
    # Set Bundle ID based on main app's ID
    if main_bundle_id
        config.build_settings['PRODUCT_BUNDLE_IDENTIFIER'] = "#{main_bundle_id}.#{target_name}"
    end
    
    # Set entitlements file
    if entitlements && !entitlements.empty?
        config.build_settings['CODE_SIGN_ENTITLEMENTS'] = entitlements
    end
  end

  # --- File & Group Handling ---
  # Using the more standard blue group and direct file reference method
  # which is more compatible with CocoaPods.
  puts "Adding file references for #{target_name}..."
  group = project.main_group.find_subpath(target_name, true)
  group.clear()
  group.set_source_tree('<group>')
  group.set_path(target_name)

  # Add source files to the "Compile Sources" build phase
  source_files.each do |file_path|
      file_ref = group.new_file(File.basename(file_path))
      target.add_file_references([file_ref])
  end

  # Add resource files to the "Copy Bundle Resources" build phase
  all_resource_files = resource_files + [info_plist]
  if entitlements && !entitlements.empty?
      all_resource_files << entitlements
  end
  resource_refs = all_resource_files.map { |f| group.new_file(File.basename(f)) }
  target.add_resources(resource_refs)

  embed_extension_in_main_target(project, target)
  
  project.save
  puts "✅ Successfully configured target '#{target_name}' in #{File.basename(project_path)}."
end


# --- Script Entry Point ---
# The script now uses a more generic argument structure
xcodeproj_path = ARGV[0]
command = ARGV[1]

if command == "SmartechNCE"
    add_extension_target(
        xcodeproj_path, "SmartechNCE",
        "com.apple.product-type.app-extension.notification-content",
        "SmartechNCE/Info.plist", "SmartechNCE/SmartechNCE.entitlements",
        ["SmartechNCE/NotificationViewController.swift"],
        ["SmartechNCE/MainInterface.storyboard", "SmartechNCE/Media.xcassets"]
    )
elsif command == "SmartechNSE"
    add_extension_target(
        xcodeproj_path, "SmartechNSE",
        "com.apple.product-type.app-extension.notification-service",
        "SmartechNSE/Info.plist", "SmartechNSE/SmartechNSE.entitlements",
        ["SmartechNSE/NotificationService.swift"], []
    )
end

"""
    with open(script_path, "w") as f:
        f.write(ruby_code)

def add_target_with_ruby(xcodeproj_path, command):
    # The ruby script is now self-contained and takes a simple command
    ruby_script_name = "add_smartech_target.rb"
    ruby_script_full_path = os.path.join(os.path.dirname(xcodeproj_path), ruby_script_name)

    try:
        # Write the ruby script into the 'ios' directory
        write_ruby_add_target_script(ruby_script_full_path)

        # Get the base name of the project (e.g., "Runner.xcodeproj")
        project_basename = os.path.basename(xcodeproj_path)

        print(f"\n--- Running Ruby script to configure '{command}' target ---")
        if command == "SmartechNCE":
            product_type = "com.apple.product-type.app-extension.notification-content"
        elif command == "SmartechNSE":
            product_type = "com.apple.product-type.app-extension.notification-service"
        else:
            product_type = ""

        subprocess.run([
            "ruby",
            ruby_script_name,
            project_basename,
            command,
            product_type # Pass the product type to the Ruby script
        ], check=True, cwd=os.path.dirname(xcodeproj_path), capture_output=False) # Run from 'ios' dir

    except subprocess.CalledProcessError as e:
        print(f"❌ An error occurred while running the Ruby script for {command}.")
        print(f"   Stderr: {e.stderr.decode() if e.stderr else 'N/A'}")
        print(f"   Stdout: {e.stdout.decode() if e.stdout else 'N/A'}")
    except Exception as e:
        print(f"❌ An unexpected error occurred: {e}")
    finally:
        # Clean up the script file
        if os.path.exists(ruby_script_full_path):
            os.remove(ruby_script_full_path)
    # The ruby script is now self-contained and takes a simple command
    ruby_script_name = "add_smartech_target.rb"
    ruby_script_path = os.path.join(os.path.dirname(xcodeproj_path), ruby_script_name)

    try:
        # Write the ruby script into the 'ios' directory
        write_ruby_add_target_script(ruby_script_path)

        # Get the base name of the project (e.g., "Runner.xcodeproj")
        project_basename = os.path.basename(xcodeproj_path)

        print(f"\n--- Running Ruby script to configure '{command}' target ---")
        if command == "SmartechNCE":
            product_type = "com.apple.product-type.app-extension.notification-content"
        elif command == "SmartechNSE":
            product_type = "com.apple.product-type.app-extension.notification-service"
        else:
            product_type = ""

        subprocess.run([
            "ruby",
            ruby_script_name,
            project_basename,
            command,
            product_type # Pass the product type to the Ruby script
        ], check=True, cwd=os.path.dirname(xcodeproj_path), capture_output=False) # Run from 'ios' dir

    except subprocess.CalledProcessError as e:
        print(f"❌ An error occurred while running the Ruby script for {command}.")
        print(f"   Stderr: {e.stderr.decode() if e.stderr else 'N/A'}")
        print(f"   Stdout: {e.stdout.decode() if e.stdout else 'N/A'}")
    except Exception as e:
        print(f"❌ An unexpected error occurred: {e}")
    finally:
        # Clean up the script file
        if os.path.exists(ruby_script_path):
            os.remove(ruby_script_path)


def ensure_podfile_exists_and_install(ios_project_path):
    podfile_path = os.path.join(ios_project_path, "Podfile")
    if not os.path.exists(podfile_path):
        print(f"Podfile not found at {podfile_path}. Running 'pod init'...")
        # Remove any Podfile.lock or Pods directory to avoid conflicts
        podfile_lock = os.path.join(ios_project_path, "Podfile.lock")
        pods_dir = os.path.join(ios_project_path, "Pods")
        if os.path.exists(podfile_lock):
            os.remove(podfile_lock)
        if os.path.exists(pods_dir):
            shutil.rmtree(pods_dir)
        # Run pod init
        result = subprocess.run(["pod", "init"], cwd=ios_project_path)
        if result.returncode != 0:
            print("❌ Failed to run 'pod init'. Please ensure CocoaPods is installed.")
            sys.exit(1)
        print("✅ Podfile created.")
    else:
        print("Podfile already exists.")
    # Always run pod install to ensure workspace is set up
        print("Running 'pod install'...")
        result = subprocess.run(["pod", "install"], cwd=ios_project_path)
        if result.returncode != 0:
            print("❌ Failed to run 'pod install'. Please ensure CocoaPods is installed.")
            sys.exit(1)
        print("✅ Pods installed.")
        
def get_url_scheme_from_user():
    while True:
        url_scheme = input("Enter a custom URL scheme for your app (e.g., myapp): ").strip()
        if url_scheme:
            return url_scheme
        print("  URL scheme cannot be empty.")

def main():
    print("Starting Smartech/Hansel project configuration script...")

    # Ask for app type and set use_override flag
    app_type = ask_app_type()
    use_override = (app_type == 2)  # True for Flutter, False otherwise

        # Set ios_project_path based on app type
    if app_type == 1:  # Native iOS
        ios_project_path = os.getcwd()
    else:  # Flutter, React Native, Cordova, Ionic
        ios_project_path = os.path.join(os.getcwd(), "ios")

    ios_project_path = os.path.join(os.getcwd(), "ios")
    ensure_podfile_exists_and_install(ios_project_path)

    plist_path = find_info_plist(EXCLUDE_DIRS)
    app_delegate_details_dict = find_app_delegate_details(EXCLUDE_DIRS)
    app_delegate_name, app_delegate_file_path, app_delegate_language, app_entry_type = None, None, None, "Unknown"
    if app_delegate_details_dict:
        if 'error' in app_delegate_details_dict:
             print(f"\n>>> App Entry Point Search Error: {app_delegate_details_dict['error']} <<<")
             if "Python 3.5+" in app_delegate_details_dict.get('error',''): sys.exit(1)
        else:
            app_delegate_name = app_delegate_details_dict.get('name')
            app_delegate_file_path = app_delegate_details_dict.get('path')
            app_delegate_language = app_delegate_details_dict.get('language')
            if app_delegate_name and app_delegate_file_path and app_delegate_language:
                app_entry_type = f"SwiftUI App Struct ({app_delegate_name})" if app_delegate_language == 'swiftui_app' else f"AppDelegate ({app_delegate_name}, {app_delegate_language})"
                print(f"\n>>> Found App Entry Point: {app_entry_type} <<<")
                print(f"    Path: {app_delegate_file_path}")
            else: app_entry_type = "Incompletely Identified"
    else: app_entry_type = "Not Found"
    if not plist_path:
        print("\nScript aborted: Could not find a suitable Info.plist file.")
        sys.exit(1)
    smartech_user_data = get_smartech_keys_from_user()
    if not smartech_user_data:
        print("\nScript aborted: Smartech configuration is required and was not provided/cancelled.")
        sys.exit(1)
    hansel_user_data, user_opted_for_hansel = get_hansel_keys_from_user()
    if user_opted_for_hansel and not hansel_user_data:
         print("\nWarning: Hansel SDK opted-in, but keys were not provided. Hansel setup will be skipped.")
         user_opted_for_hansel = False

    # --- Ask for URL scheme after Hansel keys ---
    url_scheme = get_url_scheme_from_user()

    # --- Ensure main target capabilities using Ruby script ---
    xcodeproj_name = find_xcodeproj_name(ios_project_path)
    ensure_capabilities_rb_path = os.path.join("ios", "ensure_capabilities.rb")
    try:
        if xcodeproj_name:
            xcodeproj_path = os.path.join(ios_project_path, xcodeproj_name)
            if not os.path.exists(ensure_capabilities_rb_path):
                write_ensure_capabilities_ruby_script(ensure_capabilities_rb_path)

            # Now safe to call
            ensure_capabilities_with_ruby(
                xcodeproj_path,
                smartech_user_data["SmartechAppGroup"],
            )
        else:
            print("⚠️  Could not detect an .xcodeproj in the ios directory for capability checks.")
        # ...rest of your main() code...
    finally:
        # Clean up ensure_capabilities.rb after use
        if os.path.exists(ensure_capabilities_rb_path):
            try:
                os.remove(ensure_capabilities_rb_path)
                print("🧹 Removed ensure_capabilities.rb after processing.")
            except Exception as e:
                print(f"⚠️ Could not remove ensure_capabilities.rb: {e}")

    # --- Modifying Info.plist: {plist_path} ---
    backup_plist_path = plist_path + '.backup'
    plist_modified = False
    try:
        print(f"Backing up Info.plist to {backup_plist_path}")
        os.makedirs(os.path.dirname(backup_plist_path), exist_ok=True)
        with open(plist_path, 'rb') as f_read, open(backup_plist_path, 'wb') as f_write:
            f_write.write(f_read.read())
        with open(plist_path, 'rb') as fp:
            try: plist_data = plistlib.load(fp)
            except Exception as e: print(f"Error: Failed to parse Info.plist. Error: {e}"); raise
        keys_added_or_updated_plist = []
        if plist_data.get('SmartechKeys') != smartech_user_data:
            plist_data['SmartechKeys'] = smartech_user_data
            keys_added_or_updated_plist.append("SmartechKeys"); plist_modified = True
        if user_opted_for_hansel and hansel_user_data and plist_data.get('HanselKeys') != hansel_user_data:
            plist_data['HanselKeys'] = hansel_user_data
            keys_added_or_updated_plist.append("HanselKeys"); plist_modified = True
        elif not user_opted_for_hansel and 'HanselKeys' in plist_data:
            del plist_data['HanselKeys']
            keys_added_or_updated_plist.append("HanselKeys (Removed)"); plist_modified = True

        # --- Add or update URL scheme ---
        if url_scheme:
            url_types = plist_data.get('CFBundleURLTypes', [])
            # Check if the scheme already exists
            scheme_exists = any(
                url_type.get('CFBundleURLSchemes') and url_scheme in url_type['CFBundleURLSchemes']
                for url_type in url_types
            )
            if not scheme_exists:
                url_types.append({
                    'CFBundleURLName': url_scheme,
                    'CFBundleURLSchemes': [url_scheme]
                })
                plist_data['CFBundleURLTypes'] = url_types
                keys_added_or_updated_plist.append("CFBundleURLTypes (added/updated)")
                plist_modified = True

        if plist_modified:
            with open(plist_path, 'wb') as fp:
                plistlib.dump(plist_data, fp, fmt=plistlib.FMT_XML if sys.version_info >= (3, 4) else None)
            print(f"Successfully updated Info.plist for: {', '.join(keys_added_or_updated_plist)}.")
        else:
            print("Info.plist already contains the necessary SDK key configurations or no changes were opted for.")
    except Exception as e:
        print(f"Error modifying Info.plist: {e}"); sys.exit(1)

    appdelegate_modified_flag = False
    if app_delegate_file_path and app_delegate_language in ['swift', 'objc']:
        appdelegate_modified_flag = modify_app_delegate(
            app_delegate_file_path, app_delegate_language,
            user_opted_for_hansel and bool(hansel_user_data),
            use_override=use_override
        )
    elif app_delegate_language == 'swiftui_app':
        print("\n--- Manual Integration Required (SwiftUI App) ---")
        print("Detected a SwiftUI App struct. Automatic code insertion is not fully supported.")
        print("Please manually ensure all required Smartech delegate methods and setup are present in your UIApplicationDelegateAdaptor class.")
    else:
        print("\n--- Manual Integration Required (AppDelegate Not Found/Unsupported) ---")
        print("Could not find a suitable AppDelegate or language not supported for full automatic modification.")
        print("Please manually ensure all required Smartech delegate methods and setup are present.")
    print("\n--- Script Finished ---")
    if plist_modified: print(f"✅ Info.plist ({plist_path}) was modified. Backup: {backup_plist_path}")
    else: print(f"ℹ️ Info.plist ({plist_path}) was checked. No changes made or needed.")
    if app_delegate_file_path and app_delegate_language in ['swift', 'objc']:
        backup_ad_path = app_delegate_file_path + '.backup'
        if appdelegate_modified_flag:
            print(f"✅ AppDelegate ({app_delegate_file_path}) was modified. Backup: {backup_ad_path}")
            print("   🚨 PLEASE REVIEW THE APPDELEGATE FILE FOR CORRECTNESS! 🚨")
        else:
            print(f"ℹ️ AppDelegate ({app_delegate_file_path}) modification attempt finished. Review logs for details. Backup: {backup_ad_path}")
    elif app_delegate_language == 'swiftui_app' or not app_delegate_file_path:
         print(f"ℹ️ Automatic AppDelegate modification was skipped (Reason: {app_entry_type}). See instructions above.")

    # --- Detect Xcode project name automatically ---
    ios_project_path = os.path.join(os.getcwd(), "ios")
    xcodeproj_name = find_xcodeproj_name(ios_project_path)
    if xcodeproj_name:
        print(f"Detected Xcode project: {xcodeproj_name}")
        # --- Auto-fix shellScript arrays in pbxproj for xcodeproj Ruby compatibility ---
        pbxproj_path = os.path.join(ios_project_path, xcodeproj_name, "project.pbxproj")
        fix_shellscript_arrays_in_pbxproj(pbxproj_path)
    else:
        print("⚠️  Could not detect an .xcodeproj in the ios directory.")

    # --- Create SmartechNCE and SmartechNSE extensions ---
    create_smartech_extensions(
        smartech_app_group=smartech_user_data["SmartechAppGroup"],
        smartech_app_id=smartech_user_data["SmartechAppId"],
        ios_project_path=ios_project_path
    )

    # --- Add SmartechNCE and SmartechNSE as Xcode targets using Ruby ---
    if xcodeproj_name:
        xcodeproj_path = os.path.join(ios_project_path, xcodeproj_name)
        # Call for Notification Content Extension
        add_target_with_ruby(
            xcodeproj_path,
            "SmartechNCE"
        )
        # Call for Notification Service Extension
        add_target_with_ruby(
            xcodeproj_path,
            "SmartechNSE"
        )
    else:
        print("⚠️  Could not add extension targets because .xcodeproj was not found.")

    # --- Add SmartechNSE and SmartechNCE extension targets to Podfile ---
    podfile_path = os.path.join(ios_project_path, "Podfile")
    is_flutter = (app_type == 2)
    ensure_smartech_extension_targets_in_podfile(podfile_path, is_flutter)
    
def ensure_capabilities_with_ruby(xcodeproj_path, app_group_id):
    ruby_script = "ensure_capabilities.rb"
    subprocess.run([
        "ruby", ruby_script,
        os.path.basename(xcodeproj_path),
        app_group_id
    ], check=True, cwd="ios")

def ensure_smartech_extension_targets_in_podfile(podfile_path, is_flutter):
    try:
        with open(podfile_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"⚠️  Podfile not found at {podfile_path}. Skipping Podfile extension target addition.")
        return

    # Remove any existing SmartechNSE/NCE extension targets
    content = re.sub(
        r"#service extension target\s*target 'SmartechNSE'.*?end\s*#content extension target\s*target 'SmartechNCE'.*?end\s*",
        "",
        content,
        flags=re.DOTALL
    )

    use_fw = "  use_frameworks!\n" if is_flutter else ""
    extension_targets = (
        "\n#service extension target\n"
        "target 'SmartechNSE' do\n"
        f"{use_fw}"
        "  pod 'SmartPush-iOS-SDK'\n"
        "end\n\n"
        "#content extension target\n"
        "target 'SmartechNCE' do\n"
        f"{use_fw}"
        "  pod 'SmartPush-iOS-SDK'\n"
        "end\n"
    )

    # Add extension targets at the end of the file
    if content.rstrip().endswith('end'):
        # If file ends with 'end', add a newline before adding extensions
        content = content.rstrip() + "\n" + extension_targets
    else:
        content = content.rstrip() + extension_targets

    with open(podfile_path, 'w', encoding='utf-8') as f:
        f.write(content)
    print("✅ SmartechNSE and SmartechNCE targets added to Podfile")

def ask_app_type():
    print("\nWhat type of app are you integrating Smartech with?")
    print("1. Native iOS")
    print("2. Flutter")
    print("3. React Native")
    print("4. Cordova")
    print("5. Ionic")
    while True:
        choice = input("Enter the number (1-5): ")
        if choice in ['1', '2', '3', '4', '5']:
            return int(choice)
        else:
            print("Invalid input. Please enter a number between 1 and 5.")

# --- Execute the main routine ---
if __name__ == "__main__":
    main()