import plistlib
import os
import glob
import sys
import re

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
        swift_delegate_files = filter_paths(glob.glob('./**/AppDelegate.swift', recursive=True), exclusions)
        objc_delegate_files = filter_paths(glob.glob('./**/AppDelegate.m', recursive=True), exclusions)
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
            swift_files = filter_paths(glob.glob('./**/*.swift', recursive=True), exclusions)
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
        # Debug: Print each line being checked and the patterns
        for pattern in signature_patterns:
            if pattern.search(current_line_content):
                print(f"Matched pattern '{pattern.pattern}' on line {i}: {current_line_content.strip()}")
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
    insertion_logic = config.get('insertion_logic', 'after_brace')
    add_if_missing = config.get('add_if_missing', True)
    swift_stub = config.get('swift_stub', [])
    objc_stub = config.get('objc_stub', [])
    print(f"   Processing method: {method_name}...")
    patterns = swift_patterns if language == 'swift' else objc_patterns
    sig_idx, open_brace_idx, end_idx = find_method_bounds(lines, language, patterns)
    if sig_idx != -1 and open_brace_idx != -1 and end_idx != -1:
        # Insert only if code is not already present
        method_body = ''.join(lines[open_brace_idx+1:end_idx])
        inserted = False
        for line in code_to_insert:
            if line.strip() and line.strip() not in method_body:
                indent = get_indentation(lines[open_brace_idx+1]) if open_brace_idx+1 < len(lines) else DEFAULT_INDENT
                lines.insert(open_brace_idx+1, f"{indent}{line}\n")
                inserted = True
        return lines, inserted
    elif add_if_missing:
        stub = swift_stub if language == 'swift' else objc_stub
        if not stub:
            print(f"      Error: No method stub defined for {method_name} in {language}. Cannot add method.")
            return lines, False
        class_def_line_idx = find_class_definition_line(lines, language)
        if class_def_line_idx == -1:
            print(f"      Error: Cannot find class definition for adding method '{method_name}'. Skipping.")
            return lines, False
        # Find end of class
        class_open_brace_idx = -1
        class_brace_level = 0
        class_end_brace_idx = -1
        for i in range(class_def_line_idx, len(lines)):
            line_content = lines[i]
            if class_open_brace_idx == -1:
                if '{' in line_content:
                    class_open_brace_idx = i
                    class_brace_level += line_content.count('{')
                    class_brace_level -= line_content.count('}')
                    if class_brace_level == 0 and i == class_open_brace_idx:
                        class_end_brace_idx = i; break
                    continue
            if class_open_brace_idx != -1:
                class_brace_level += line_content.count('{')
                class_brace_level -= line_content.count('}')
                if class_brace_level == 0:
                    class_end_brace_idx = i
                    break
        if class_end_brace_idx != -1:
            indent_for_new_method = get_indentation(lines[class_def_line_idx]) + DEFAULT_INDENT
            stub_to_insert = ["\n"] + [f"{indent_for_new_method}{line}\n" for line in stub]
            lines = lines[:class_end_brace_idx] + stub_to_insert + lines[class_end_brace_idx:]
            print(f"      Successfully added method '{method_name}'.")
            return lines, True
    return lines, False

def modify_app_delegate(app_delegate_file_path, language, add_hansel_code_flag):
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
                # Improved Swift patterns for more robust matching
                'swift_patterns': [
                    r"func\s+application\s*\(\s*_?\s*application:\s*UIApplication\s*,\s*didFinishLaunchingWithOptions\s*:\s*\[?\w*\.?LaunchOptionsKey:?.*\]?\s*\??\)",
                    r"func\s+application\s*\(.*didFinishLaunchingWithOptions.*\)",
                    r"(?:override\s+)?func\s+(?:application|_)\s*\(.*didFinishLaunchingWithOptions"
                ],
                # Improved ObjC pattern
                'objc_patterns': [
                    r"-\s*\(BOOL\)\s*application:\s*\(UIApplication\s*\*\)\s*\w+\s*didFinishLaunchingWithOptions:\s*\(NSDictionary\s*\*\)\s*\w+"
                ],
                'code': {
                    'swift': [
                        "UNUserNotificationCenter.current().delegate = self",
                        "Smartech.sharedInstance().initSDK(with: self, withLaunchOptions: launchOptions)",
                        "SmartPush.sharedInstance().registerForPushNotificationWithDefaultAuthorizationOptions()",
                        "Smartech.sharedInstance().setDebugLevel(.verbose) // TODO: Set appropriate debug level",
                        "Smartech.sharedInstance().trackAppInstallUpdateBySmartech()",
                        "Hansel.enableDebugLogs() // TODO: Disable debug logs for production" if add_hansel_code_flag else None,
                    ],
                    'objc': [
                        "[UNUserNotificationCenter currentNotificationCenter].delegate = self;",
                        "[[Smartech sharedInstance] initSDKWithApplication:self didFinishLaunchingWithOptions:launchOptions];",
                        "[[SmartPush sharedInstance] registerForPushNotificationWithDefaultAuthorizationOptions];",
                        "[[Smartech sharedInstance] setDebugLevel:SmartechLogLevelVerbose];",
                        "[[Smartech sharedInstance] trackAppInstallUpdateBySmartech];",
                        "[Hansel enableDebugLogs];" if add_hansel_code_flag else None,
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
                'swift_stub': ["override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {",
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
                'swift_stub': ["override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {",
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
                'marker': SMARTECH_WILL_PRESENT_MARKER, 'insertion_logic': 'after_brace', 'add_if_missing': False,
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
                'marker': SMARTECH_DID_RECEIVE_MARKER, 'insertion_logic': 'after_brace', 'add_if_missing': False,
            },
            {
                'name': 'openURL',
                'swift_patterns': [
                    r"(?:override\s+)?func\s+application\s*\(\s*_?\s*app:\s*UIApplication\s*,\s*open\s+url:\s*URL.*",
                    r"func\s+application\s*\(.*open\s+url:.*"
                ],
                'objc_patterns': [],
                'code': {'swift': [
                    "var handleBySmartech = Smartech.sharedInstance().application(app, open: url, options: options)",
                    "if(!handleBySmartech) {",
                    "    // handle the url by the app",
                    "}",
                    "return true"
                ]},
                'marker': SMARTECH_OPEN_URL_MARKER_START, 'insertion_logic': 'after_brace', 'add_if_missing': False,
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

def main():
    print("Starting Smartech/Hansel project configuration script...")
    current_date_str = "May 19, 2025"
    print(f"Current date: {current_date_str}")
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
    print(f"\n--- Modifying Info.plist: {plist_path} ---")
    backup_plist_path = plist_path + '.backup'
    plist_modified = False
    try:
        print(f"Backing up Info.plist to {backup_plist_path}")
        os.makedirs(os.path.dirname(backup_plist_path), exist_ok=True)
        with open(plist_path, 'rb') as f_read, open(backup_plist_path, 'wb') as f_write: f_write.write(f_read.read())
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
            user_opted_for_hansel and bool(hansel_user_data))
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

if __name__ == "__main__":
    if sys.version_info < (3, 6):
         print("Warning: This script is best run with Python 3.6 or newer.")
    main()
