import plistlib
import os
import glob
import sys
import re
# from datetime import date # If needed

# --- Configuration --- (Keep existing config + Add new markers)
EXCLUDE_DIRS = ['/build/', '/Pods/', '/DerivedData/', '/.git/', '/Carthage/', '/Vendor/', '/Frameworks/']
DEFAULT_INDENT = "    " # 4 spaces

# --- Markers for different code insertions ---
SMARTECH_DID_FINISH_LAUNCHING_MARKER_START = "// SMARTECH_INIT_BY_SCRIPT_START"
SMARTECH_DID_FINISH_LAUNCHING_MARKER_END = "// SMARTECH_INIT_BY_SCRIPT_END"
SMARTECH_DID_REGISTER_TOKEN_MARKER = "// SMARTECH_DID_REGISTER_TOKEN_BY_SCRIPT"
SMARTECH_DID_FAIL_REGISTER_MARKER = "// SMARTECH_DID_FAIL_REGISTER_BY_SCRIPT"
SMARTECH_WILL_PRESENT_MARKER = "// SMARTECH_WILL_PRESENT_BY_SCRIPT"
SMARTECH_DID_RECEIVE_MARKER = "// SMARTECH_DID_RECEIVE_BY_SCRIPT"
SMARTECH_OPEN_URL_MARKER_START = "// SMARTECH_OPEN_URL_BY_SCRIPT_START"
SMARTECH_OPEN_URL_MARKER_END = "// SMARTECH_OPEN_URL_BY_SCRIPT_END"
SMARTECH_DEEPLINK_HANDLER_MARKER = "// SMARTECH_DEEPLINK_HANDLER_BY_SCRIPT"
SMARTECH_UNCENTERDELEGATE_MARKER = "// SMARTECH_UNCENTERDELEGATE_BY_SCRIPT"


# --- Helper Function to Filter Paths --- (Keep existing)
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

# --- Find Info.plist function --- (Keep existing)
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
        print("Error: No Info.plist found after filtering excluded directories:")
        print(f"  Excluded patterns: {exclusions}")
        print(f"  Found before filtering: {all_plists}")
        return None
    elif len(valid_plists) > 1:
        print("Warning: Found multiple Info.plist files after filtering. Please ensure the correct one is selected.")
        valid_plists.sort(key=len)
        likely_plist = valid_plists[0]
        print(f"  Using the shortest path found: {likely_plist}")
        print("  Other potential candidates:")
        for p in valid_plists[1:]: print(f"    - {p}")
        return likely_plist
    else:
        found_path = valid_plists[0]
        print(f"Success: Found unique Info.plist at: {found_path}")
        return found_path

# --- Find App Delegate / App Struct function --- (Keep existing)
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
            print(f"Success: Found unique AppDelegate: {app_delegate_info['path']} (Language: {app_delegate_info['language']})")
        elif len(potential_delegates) > 1:
            print(f"Warning: Found multiple AppDelegate files: {[d['path'] for d in potential_delegates]}.")
            swift_appdelegate = next((d for d in potential_delegates if d['language'] == 'swift'), None)
            if swift_appdelegate:
                 app_delegate_info = swift_appdelegate
                 print(f"  Using Swift version: {app_delegate_info['path']}")
            else:
                 potential_delegates.sort(key=lambda d: len(d['path']))
                 app_delegate_info = potential_delegates[0]
                 print(f"  Using the shortest path: {app_delegate_info['path']}")

    except TypeError:
        print("Error: Recursive glob ('**/') requires Python 3.5 or newer for AppDelegate search.")
        return {'error': "Python 3.5+ Required"}

    if not app_delegate_info:
        print("Info: No conventional AppDelegate found, searching for SwiftUI App struct (@main App)...")
        try:
            swift_files = filter_paths(glob.glob('./**/*.swift', recursive=True), exclusions)
            potential_app_structs = []
            swiftui_app_regex = re.compile(r"@main\s+(?:public\s+)?struct\s+([\w]+)\s*:\s*App")
            for file_path in swift_files:
                try:
                    with open(file_path, 'r', encoding='utf-8') as f: content = f.read()
                    match = swiftui_app_regex.search(content)
                    if match:
                        app_name = match.group(1)
                        potential_app_structs.append({'path': file_path, 'name': app_name, 'language': 'swiftui_app'})
                        # print(f"  Found potential SwiftUI App struct '{app_name}' in: {file_path}") # Less verbose
                except Exception: pass

            if len(potential_app_structs) == 1:
                app_delegate_info = potential_app_structs[0]
                print(f"Success: Found unique SwiftUI App struct: {app_delegate_info['name']} in {app_delegate_info['path']}")
            elif len(potential_app_structs) > 1:
                print(f"Warning: Found multiple SwiftUI App structs: {[d['name']+' in '+d['path'] for d in potential_app_structs]}.")
                chosen_struct = None
                for struct_info in potential_app_structs:
                     project_dir_name = os.path.basename(os.path.dirname(struct_info['path']))
                     if struct_info['name'].lower() == project_dir_name.lower()+'app':
                          chosen_struct = struct_info; break
                if chosen_struct:
                     app_delegate_info = chosen_struct
                     print(f"  Using struct matching directory convention: {app_delegate_info['name']}")
                else:
                    potential_app_structs.sort(key=lambda d: len(d['path']))
                    app_delegate_info = potential_app_structs[0]
                    print(f"  Using the shortest path: {app_delegate_info['path']}")

        except TypeError: print("Warning: Recursive glob for SwiftUI App search requires Python 3.5+.")
        except Exception as e: print(f"Warning: Error during SwiftUI App search: {e}")

    if not app_delegate_info:
        print("Warning: Could not automatically find a conventional AppDelegate (Swift/ObjC) or a SwiftUI App struct.")
        return None
    return app_delegate_info

# --- Function to get boolean input from user --- (Keep existing)
def get_bool_input(prompt_message):
    while True:
        response = input(f"{prompt_message} (y/n): ").strip().lower()
        if response in ['y', 'yes']: return True
        if response in ['n', 'no']: return False
        print("Invalid input. Please enter 'y' or 'n'.")

# --- SDK Key Input Functions --- (Keep existing)
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

# --- AppDelegate Modification Helpers ---

def find_class_definition_line(lines, language, class_name="AppDelegate"):
    """Finds the line index where the main class is defined."""
    swift_class_pattern = re.compile(rf"^\s*(?:(?:private|internal|public|open)\s+)?class\s+{class_name}\s*:")
    objc_interface_pattern = re.compile(rf"^\s*@interface\s+{class_name}\s*:")
    objc_implementation_pattern = re.compile(rf"^\s*@implementation\s+{class_name}")

    interface_idx = -1
    implementation_idx = -1

    for i, line in enumerate(lines):
        if language == 'swift':
            if swift_class_pattern.match(line):
                return i
        elif language == 'objc':
            if interface_idx == -1 and objc_interface_pattern.match(line):
                interface_idx = i
            if implementation_idx == -1 and objc_implementation_pattern.match(line):
                 implementation_idx = i
                 # In ObjC, we usually add methods to the @implementation block
                 return implementation_idx # Return implementation line index

    # Fallback for ObjC if only interface was found (less ideal)
    if language == 'objc' and interface_idx != -1:
        return interface_idx

    return -1 # Not found

def find_method_bounds(lines, language, signature_patterns, start_line=0):
    """
    Finds the start line (containing signature) and end line index (containing closing '}') of a method.
    signature_patterns: A list of regex patterns to match the method signature start.
    Returns (signature_line_idx, end_brace_line_idx) or (-1, -1) if not found.
    """
    signature_line_idx = -1
    end_brace_line_idx = -1
    brace_level = 0
    in_method = False

    for i in range(start_line, len(lines)):
        line = lines[i].strip()
        # Skip comments entirely for detection
        if line.startswith("//") or line.startswith("/*") or line.startswith("*"):
             continue

        if not in_method:
            # Check if this line matches any signature pattern
            for pattern in signature_patterns:
                if pattern.search(lines[i]): # Use search to allow signature parts anywhere on the line
                    signature_line_idx = i
                    in_method = True
                    # Count braces on the signature line itself
                    brace_level += lines[i].count('{')
                    brace_level -= lines[i].count('}')
                    # If the method opens and closes on the same line (rare, e.g., empty method)
                    if brace_level == 0 and '{' in lines[i]:
                         end_brace_line_idx = i
                         return signature_line_idx, end_brace_line_idx
                    elif brace_level < 0: # Should not happen if starting outside
                         in_method = False; signature_line_idx = -1; break # Reset
                    break # Found a matching pattern, stop checking patterns for this line
            if not in_method:
                continue # Did not find signature start on this line

        # If we are inside the method, track braces
        if in_method:
            # If we found the start line, but it didn't have the opening brace, look for it
            if '{' not in lines[signature_line_idx] and brace_level == 0:
                if '{' in lines[i]:
                    brace_level += lines[i].count('{')  # Count opening brace if found after signature line
                else:
                    continue  # Still looking for the opening brace line

            # Count braces on lines after the signature (or including signature if brace was there)
            if i > signature_line_idx or '{' in lines[signature_line_idx]:
                brace_level += lines[i].count('{')
                brace_level -= lines[i].count('}')

            # Check if we found the closing brace for the method
            if brace_level <= 0:  # Use <= 0 to handle case where closing brace is on same line as opening
                end_brace_line_idx = i
                return signature_line_idx, end_brace_line_idx

    return signature_line_idx, -1 # Method start found, but end brace wasn't (or method not found)

def get_indentation(line):
    """Gets the leading whitespace indentation of a line."""
    match = re.match(r"^(\s*)", line)
    return match.group(1) if match else ""

def check_marker_within_bounds(lines, marker, start_idx, end_idx):
    """Checks if a marker exists within the given line bounds."""
    if start_idx < 0 or end_idx < 0 or start_idx > end_idx:
        return False
    for i in range(start_idx, end_idx + 1):
        if marker in lines[i]:
            return True
    return False

def add_uncenterdelegate_if_needed(lines, language, class_name="AppDelegate"):
    """Adds UNUserNotificationCenterDelegate to the class definition if missing."""
    print(f"   Checking for UNUserNotificationCenterDelegate conformance...")
    class_def_line_idx = find_class_definition_line(lines, language, class_name)
    if class_def_line_idx == -1:
        print(f"      Error: Could not find class definition for '{class_name}'. Skipping delegate check.")
        return lines, False # Indicate no modification

    class_line = lines[class_def_line_idx]

    if "UNUserNotificationCenterDelegate" in class_line:
        print(f"      Conformance already exists.")
        return lines, False # Indicate no modification

    # Add the delegate
    modified = False
    if language == 'swift':
        # Find the end of existing protocols/superclass
        if '<' in class_line and '>' in class_line: # ObjC generics syntax edge case check (unlikely here)
             pass # Avoid modifying if ObjC generics look like Swift protocol list
        elif ':' in class_line: # Already has a superclass or protocols
            # Add with a comma
            lines[class_def_line_idx] = class_line.rstrip().rstrip('{').rstrip() + ", UNUserNotificationCenterDelegate {\n"
            modified = True
        else: # No superclass or protocols yet
            lines[class_def_line_idx] = class_line.rstrip().rstrip('{').rstrip() + ": UNUserNotificationCenterDelegate {\n"
            modified = True

    elif language == 'objc':
         # Find end of protocol list <...> in @interface
         interface_match = re.match(r"(\s*@interface\s+\w+\s*:\s*\w+\s*)(<[^>]*>)?(.*)", class_line)
         if interface_match:
             prefix = interface_match.group(1)
             protocols = interface_match.group(2)
             suffix = interface_match.group(3)
             if protocols: # Existing protocols
                 # Add within the <>
                 lines[class_def_line_idx] = f"{prefix}{protocols[:-1]}, UNUserNotificationCenterDelegate>{suffix}\n"
                 modified = True
             else: # No protocols yet
                 lines[class_def_line_idx] = f"{prefix}<UNUserNotificationCenterDelegate>{suffix}\n"
                 modified = True

    if modified:
        print(f"      Added UNUserNotificationCenterDelegate conformance.")
        # Optionally add a marker comment near the modification
        lines.insert(class_def_line_idx + 1, get_indentation(lines[class_def_line_idx+1] if class_def_line_idx+1 < len(lines) else class_line) + DEFAULT_INDENT + SMARTECH_UNCENTERDELEGATE_MARKER + "\n")
        return lines, True
    else:
        print(f"      Could not automatically add conformance (maybe unusual formatting?).")
        return lines, False


def add_or_update_method(lines, language, config):
    """
    Finds a method based on config patterns.
    If found, inserts code if marker is missing.
    If not found, adds the entire method stub with code.
    Returns modified lines and a boolean indicating if changes were made.
    """
    method_name = config['name']
    swift_patterns = [re.compile(p) for p in config.get('swift_patterns', [])]
    objc_patterns = [re.compile(p) for p in config.get('objc_patterns', [])]
    code_to_insert = config['code'].get(language, [])
    marker = config['marker']
    insertion_logic = config.get('insertion_logic', 'after_brace') # 'after_brace', 'before_end_brace', 'wrap_body'
    requires_delegate = config.get('requires_delegate', False)
    add_if_missing = config.get('add_if_missing', True)
    swift_stub = config.get('swift_stub', [])
    objc_stub = config.get('objc_stub', [])

    print(f"   Processing method: {method_name}...")

    patterns = swift_patterns if language == 'swift' else objc_patterns
    if not patterns:
        print(f"      Error: No signature patterns defined for {language}. Skipping.")
        return lines, False

    sig_idx, end_idx = find_method_bounds(lines, language, patterns)

    if sig_idx != -1 and end_idx != -1:
        # Method Found - Check if already modified
        if check_marker_within_bounds(lines, marker, sig_idx, end_idx):
            print(f"      Smartech code marker '{marker}' already present. Skipping.")
            return lines, False

        # Method Found - Insert code
        print(f"      Method found at line {sig_idx + 1}. Inserting/modifying code...")
        indent = get_indentation(lines[sig_idx + 1]) if sig_idx + 1 < end_idx else get_indentation(lines[sig_idx]) + DEFAULT_INDENT

        if insertion_logic == 'after_brace':
             insert_pos = -1
             # Find first line after signature with '{'
             for i in range(sig_idx, end_idx + 1):
                  if '{' in lines[i]:
                       insert_pos = i + 1
                       # Get indentation from line *after* the brace line for insertion
                       indent = get_indentation(lines[i+1]) if i+1 <= end_idx else get_indentation(lines[i]) + DEFAULT_INDENT
                       break
             if insert_pos != -1:
                 code_with_marker = [f"{indent}{line} {marker}\n" if i == 0 else f"{indent}{line}\n" for i, line in enumerate(code_to_insert)]
                 lines = lines[:insert_pos] + code_with_marker + lines[insert_pos:]
                 return lines, True
             else:
                  print(f"      Error: Could not find opening brace '{{' for method {method_name}. Skipping insertion.")
                  return lines, False

        elif insertion_logic == 'before_end_brace':
             indent = get_indentation(lines[end_idx-1]) if end_idx > sig_idx + 1 else get_indentation(lines[sig_idx]) + DEFAULT_INDENT
             code_with_marker = [f"{indent}{line} {marker}\n" if i == 0 else f"{indent}{line}\n" for i, line in enumerate(code_to_insert)]
             lines = lines[:end_idx] + code_with_marker + lines[end_idx:]
             return lines, True

        elif insertion_logic == 'wrap_body':
             # --- Special handling for openURL ---
             print(f"      Applying wrap logic for {method_name}...")
             open_brace_line = -1
             for i in range(sig_idx, end_idx + 1):
                  if '{' in lines[i]:
                       open_brace_line = i; break

             if open_brace_line == -1:
                  print(f"      Error: Could not find opening brace '{{' for wrapping method {method_name}. Skipping.")
                  return lines, False

             # Extract original body (between { and } )
             original_body_lines = []
             # Be careful about nested braces - simple extraction might be brittle.
             # Assuming simple structure for now: extract lines between open_brace_line+1 and end_idx-1
             if end_idx > open_brace_line + 1:
                  original_body_lines = lines[open_brace_line+1 : end_idx]

             # Find indentation for the original body lines
             body_indent = ""
             if original_body_lines:
                 body_indent = get_indentation(original_body_lines[0])
             else: # Empty original body
                 body_indent = get_indentation(lines[open_brace_line]) + DEFAULT_INDENT


             # Prepare new Smartech code block
             smartech_var_line = config['code'][language][0] # e.g., let handleBySmartech = ...
             smartech_if_start = config['code'][language][1] # e.g., if !handleBySmartech {
             smartech_if_end = config['code'][language][2]   # e.g., }
             smartech_return = config['code'][language][3]   # e.g., return true

             wrap_indent = get_indentation(lines[open_brace_line+1]) if open_brace_line+1 < end_idx else get_indentation(lines[open_brace_line]) + DEFAULT_INDENT

             new_block = []
             new_block.append(f"{wrap_indent}{smartech_var_line} {marker}\n") # Marker on first line
             new_block.append(f"{wrap_indent}{smartech_if_start}\n")
             # Add original body lines, ensuring they have at least the inner indent
             for orig_line in original_body_lines:
                  # Simple re-indent: ensure it has wrap_indent + DEFAULT_INDENT
                  # A more robust re-indent might be needed for complex original code
                  new_block.append(f"{body_indent}{orig_line.lstrip()}") # Preserve relative indent
             new_block.append(f"{wrap_indent}{smartech_if_end}\n")
             new_block.append(f"{wrap_indent}{smartech_return}\n") # Ensure return is present

             # Replace original method body content
             lines = lines[:open_brace_line+1] + new_block + lines[end_idx:] # Replace from after { to before }
             return lines, True
             # --- End wrap_body logic ---

        else:
             print(f"      Error: Unknown insertion logic '{insertion_logic}'. Skipping.")
             return lines, False

    elif add_if_missing:
        # Method Not Found - Add it
        print(f"      Method not found. Adding new method definition...")
        stub = swift_stub if language == 'swift' else objc_stub
        if not stub:
            print(f"      Error: No method stub defined for {language}. Cannot add method.")
            return lines, False

        # Find where to insert the new method (e.g., before the class end)
        class_def_line = find_class_definition_line(lines, language)
        if class_def_line == -1:
             print(f"      Error: Cannot find class definition to add method {method_name}. Skipping.")
             return lines, False

        # Find the end of the class implementation
        class_end_line = -1
        brace_level = 0
        found_class_start_brace = False
        start_search = class_def_line # Start searching from class definition line

        for i in range(start_search, len(lines)):
             # Count braces only after the line containing the class definition's opening brace
             if '{' in lines[i] and i >= class_def_line:
                 if not found_class_start_brace:
                      found_class_start_brace = True
                 brace_level += lines[i].count('{')

             if '}' in lines[i] and found_class_start_brace: # Only count closing braces after we found the first opening one
                 brace_level -= lines[i].count('}')

             # Check if the class definition line itself contains the brace
             if i == class_def_line and '{' not in lines[i]:
                  continue # Need to find the opening brace first

             if found_class_start_brace and brace_level == 0:
                  # We might have found the end if the brace level returned to 0
                  # Need refinement: Find the '@end' for ObjC implementation
                  if language == 'objc' and lines[i].strip() == '@end':
                       class_end_line = i
                       break
                  elif language == 'swift' and lines[i].strip() == '}':
                       # Make sure it's not a nested structure closing brace
                       # This is tricky; assume the first time level is 0 after start is the class end
                       class_end_line = i
                       break
        # Fallback for Swift if precise end not found, insert before last line maybe? Risky.
        if language == 'swift' and class_end_line == -1 and lines[-1].strip() == '}':
             class_end_line = len(lines) - 1


        if class_end_line != -1:
            indent = get_indentation(lines[class_end_line-1]) if class_end_line > 0 else "" # Indent like previous line
            # Add marker comment to the stub itself for clarity
            stub_with_marker = [f"{indent}{line} {marker}\n" if i == 1 else f"{indent}{line}\n" for i, line in enumerate(stub)]
            # Add blank lines before/after for spacing
            insert_block = ["\n"] + stub_with_marker + ["\n"]
            lines = lines[:class_end_line] + insert_block + lines[class_end_line:]
            print(f"      Successfully added method {method_name}.")
            return lines, True
        else:
            print(f"      Error: Could not find end of class definition to add method {method_name}. Skipping.")
            return lines, False
    else:
        # Method not found and add_if_missing is False
        print(f"      Method not found. Skipping (add_if_missing is False).")
        return lines, False


# --- Main AppDelegate Modification Function ---
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
        return False # Critical error, stop

    overall_success = True
    made_changes = False
    lines = []
    try:
        with open(app_delegate_file_path, 'r', encoding='utf-8') as file:
            lines = file.readlines()

        # --- Define Method Configurations ---
        methods_to_process = [
            {
                'name': 'didFinishLaunchingWithOptions',
                'swift_patterns': [r"func\s+application\s*\(.*didFinishLaunchingWithOptions"],
                'objc_patterns': [r"-\s*\(.*didFinishLaunchingWithOptions:"],
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
                        "[[Smartech sharedInstance] setDebugLevel:SmartechLogLevelVerbose]; // TODO: Set appropriate debug level",
                        "[[Smartech sharedInstance] trackAppInstallUpdateBySmartech];",
                         "[Hansel enableDebugLogs]; // TODO: Disable debug logs for production" if add_hansel_code_flag else None,
                    ]
                 },
                 # Filter out None values if Hansel wasn't added
                'code': {lang: [line for line in lines if line is not None] for lang, lines in {
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
                        "[[Smartech sharedInstance] setDebugLevel:SmartechLogLevelVerbose]; // TODO: Set appropriate debug level",
                        "[[Smartech sharedInstance] trackAppInstallUpdateBySmartech];",
                         "[Hansel enableDebugLogs]; // TODO: Disable debug logs for production" if add_hansel_code_flag else None,
                    ]
                 }.items()},
                'marker': SMARTECH_DID_FINISH_LAUNCHING_MARKER_START, # Use start marker for block check
                'insertion_logic': 'after_brace',
                'add_if_missing': False # Should always exist
            },
            {
                'name': 'didRegisterForRemoteNotificationsWithDeviceToken',
                'swift_patterns': [r"func\s+application\s*\(.*didRegisterForRemoteNotificationsWithDeviceToken\s*:\s*Data"],
                'objc_patterns': [r"-\s*\(.*didRegisterForRemoteNotificationsWithDeviceToken\s*:\s*NSData"],
                'code': {
                    'swift': ["SmartPush.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)"],
                    'objc': ["[[SmartPush sharedInstance] didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];"]
                 },
                'marker': SMARTECH_DID_REGISTER_TOKEN_MARKER,
                'insertion_logic': 'after_brace',
                'add_if_missing': True,
                'swift_stub': [
                    "func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {",
                    f"{DEFAULT_INDENT}// SMARTECH: Handle device token registration",
                    f"{DEFAULT_INDENT}SmartPush.sharedInstance().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)",
                    "}"
                ],
                 'objc_stub': [
                    "- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {",
                    f"{DEFAULT_INDENT}// SMARTECH: Handle device token registration",
                    f"{DEFAULT_INDENT}[[SmartPush sharedInstance] didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];",
                    "}"
                 ]
            },
             {
                'name': 'didFailToRegisterForRemoteNotificationsWithError',
                'swift_patterns': [r"func\s+application\s*\(.*didFailToRegisterForRemoteNotificationsWithError\s*:\s*Error"],
                'objc_patterns': [r"-\s*\(.*didFailToRegisterForRemoteNotificationsWithError\s*:\s*NSError"],
                'code': {
                    'swift': ["SmartPush.sharedInstance().didFailToRegisterForRemoteNotificationsWithError(error)"],
                    'objc': ["[[SmartPush sharedInstance] didFailToRegisterForRemoteNotificationsWithError:error];"]
                 },
                'marker': SMARTECH_DID_FAIL_REGISTER_MARKER,
                'insertion_logic': 'after_brace',
                'add_if_missing': True,
                'swift_stub': [
                    "func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {",
                    f"{DEFAULT_INDENT}// SMARTECH: Handle registration failure",
                    f"{DEFAULT_INDENT}SmartPush.sharedInstance().didFailToRegisterForRemoteNotificationsWithError(error)",
                    f"{DEFAULT_INDENT}print(\"Failed to register for remote notifications: \\(error.localizedDescription)\") // Add standard logging",
                    "}"
                ],
                 'objc_stub': [
                    "- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {",
                    f"{DEFAULT_INDENT}// SMARTECH: Handle registration failure",
                    f"{DEFAULT_INDENT}[[SmartPush sharedInstance] didFailToRegisterForRemoteNotificationsWithError:error];",
                    f"{DEFAULT_INDENT}NSLog(@\"Failed to register for remote notifications: %@\", error.localizedDescription); // Add standard logging",
                    "}"
                 ]
            },
             {
                'name': 'userNotificationCenter:willPresent',
                'swift_patterns': [r"func\s+userNotificationCenter\s*\(.*willPresent\s*:"],
                'objc_patterns': [r"-\s*\(.*userNotificationCenter\s*:.*willPresentNotification\s*:"],
                'code': { # Insert Smartech call, assume completionHandler call exists/is added in stub
                    'swift': ["SmartPush.sharedInstance().willPresentForegroundNotification(notification)"],
                    'objc': ["[[SmartPush sharedInstance] willPresentForegroundNotification:notification];"]
                 },
                'marker': SMARTECH_WILL_PRESENT_MARKER,
                'insertion_logic': 'after_brace', # Insert near top
                'add_if_missing': True,
                'requires_delegate': True, # Belongs to UNUserNotificationCenterDelegate
                'swift_stub': [
                    "// MARK: - UNUserNotificationCenterDelegate Methods", # Add section marker
                    "func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {",
                    f"{DEFAULT_INDENT}// SMARTECH: Handle foreground notification presentation",
                    f"{DEFAULT_INDENT}SmartPush.sharedInstance().willPresentForegroundNotification(notification)",
                    f"{DEFAULT_INDENT}// Decide how to present the notification to the user. Add [.list, .banner] for iOS 14+",
                    f"{DEFAULT_INDENT}completionHandler([.alert, .sound])",
                    "}"
                ],
                 'objc_stub': [
                    "#pragma mark - UNUserNotificationCenterDelegate Methods", # Add section marker
                    "- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {",
                    f"{DEFAULT_INDENT}// SMARTECH: Handle foreground notification presentation",
                    f"{DEFAULT_INDENT}[[SmartPush sharedInstance] willPresentForegroundNotification:notification];",
                    f"{DEFAULT_INDENT}// Decide how to present the notification to the user. Add UNNotificationPresentationOptionList | UNNotificationPresentationOptionBanner for iOS 14+",
                    f"{DEFAULT_INDENT}completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);",
                    "}"
                 ]
            },
             {
                'name': 'userNotificationCenter:didReceive',
                'swift_patterns': [r"func\s+userNotificationCenter\s*\(.*didReceive\s*:"],
                'objc_patterns': [r"-\s*\(.*userNotificationCenter\s*:.*didReceiveNotificationResponse\s*:"],
                 'code': { # Insert Smartech call, assume completionHandler call exists/is added in stub
                    'swift': ["SmartPush.sharedInstance().didReceive(response)"],
                    'objc': ["[[SmartPush sharedInstance] didReceiveNotificationResponse:response];"]
                 },
                'marker': SMARTECH_DID_RECEIVE_MARKER,
                'insertion_logic': 'after_brace', # Insert near top
                'add_if_missing': True,
                'requires_delegate': True, # Belongs to UNUserNotificationCenterDelegate
                'swift_stub': [
                    "func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {",
                    f"{DEFAULT_INDENT}// SMARTECH: Handle notification response",
                    f"{DEFAULT_INDENT}SmartPush.sharedInstance().didReceive(response)",
                    f"{DEFAULT_INDENT}// Add any custom handling based on response.actionIdentifier etc.",
                    f"{DEFAULT_INDENT}completionHandler()",
                    "}"
                ],
                 'objc_stub': [
                    "- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {",
                    f"{DEFAULT_INDENT}// SMARTECH: Handle notification response",
                    f"{DEFAULT_INDENT}[[SmartPush sharedInstance] didReceiveNotificationResponse:response];",
                    f"{DEFAULT_INDENT}// Add any custom handling based on response.actionIdentifier etc.",
                    f"{DEFAULT_INDENT}completionHandler();",
                    "}"
                 ]
            },
            {
                'name': 'application:openURL:options',
                'swift_patterns': [r"func\s+application\s*\(\s*_?\s*(app|application)\s*:\s*UIApplication,\s*open\s+url\s*:\s*URL"], # More specific
                'objc_patterns': [r"-\s*\(.*application\s*:\s*.*\s*openURL\s*:\s*NSURL"], # Basic check
                'code': {
                    'swift': [
                        "let handleBySmartech = Smartech.sharedInstance().application(app, open: url, options: options)",
                        "if !handleBySmartech {",
                        "}",
                        "return true" # Assumes default return is true if Smartech handles it or if original code runs
                        ],
                    'objc': [
                        "BOOL handleBySmartech = [[Smartech sharedInstance] application:app openURL:url options:options];",
                         "if (!handleBySmartech) {",
                         "}",
                         "return YES;"
                         ]
                 },
                'marker': SMARTECH_OPEN_URL_MARKER_START, # Use start marker for block check
                'insertion_logic': 'wrap_body',
                'add_if_missing': True, # Add if needed, though usually present
                'swift_stub': [
                    "func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {",
                    f"{DEFAULT_INDENT}{DEFAULT_INDENT}let handleBySmartech = Smartech.sharedInstance().application(app, open: url, options: options)",
                    f"{DEFAULT_INDENT}{DEFAULT_INDENT}if !handleBySmartech {{",
                    f"{DEFAULT_INDENT}{DEFAULT_INDENT}    // Add any custom URL handling logic here if needed",
                    f"{DEFAULT_INDENT}{DEFAULT_INDENT}}}",
                    f"{DEFAULT_INDENT}{DEFAULT_INDENT}return true // Or return handleBySmartech if custom logic might return false",
                    "}"
                ],
                'objc_stub': [
                    "- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {",
                    f"{DEFAULT_INDENT}BOOL handleBySmartech = [[Smartech sharedInstance] application:app openURL:url options:options];",
                    f"{DEFAULT_INDENT}if (!handleBySmartech) {{",
                    f"{DEFAULT_INDENT}    // Add any custom URL handling logic here if needed",
                    f"{DEFAULT_INDENT}}}",
                    f"{DEFAULT_INDENT}return YES; // Or return handleBySmartech if custom logic might return NO",
                    "}"
                 ]
            },
            # Configuration to add the new handleDeeplinkAction function
             {
                'name': 'handleDeeplinkAction',
                'swift_patterns': [r"func\s+handleDeeplinkAction\s*\("], # Just check if it exists
                'objc_patterns': [r"-\s*\(.*handleDeeplinkActionWithURLString\s*:"],
                'code': {}, # No code to insert into existing, just add the stub
                'marker': SMARTECH_DEEPLINK_HANDLER_MARKER, # Marker will be in the stub
                'insertion_logic': 'after_brace', # Not applicable when adding
                'add_if_missing': True,
                'swift_stub': [
                     "// MARK: - Smartech Deeplink Handling",
                    f"func handleDeeplinkAction(withURLString deeplinkURLString: String, andNotificationPayload notificationPayload: [AnyHashable : Any]?) {{ {SMARTECH_DEEPLINK_HANDLER_MARKER}",
                    f"{DEFAULT_INDENT}// This function can be called from didReceive Notification Response or openURL",
                    f"{DEFAULT_INDENT}print(\"Smartech: Handling deeplink: \\(deeplinkURLString)\")",
                    f"{DEFAULT_INDENT}// SmartechBasePlugin is typically for Cordova/React Native. Use direct SDK call for native:",
                    f"{DEFAULT_INDENT}// Smartech.sharedInstance().handleDeeplink(with: url, andCustomPayload: notificationPayload) // Adjust based on actual SDK method",
                    f"{DEFAULT_INDENT}// OR if SmartechBasePlugin is intended (e.g. for hybrid apps using native delegate):",
                    f"{DEFAULT_INDENT}// SmartechBasePlugin.handleDeeplinkAction(deeplinkURLString, andCustomPayload: notificationPayload)",
                    "}"
                ],
                 'objc_stub': [
                     "#pragma mark - Smartech Deeplink Handling",
                    f"- (void)handleDeeplinkActionWithURLString:(NSString *)deeplinkURLString andNotificationPayload:(NSDictionary *)notificationPayload {{ {SMARTECH_DEEPLINK_HANDLER_MARKER}",
                    f"{DEFAULT_INDENT}// This function can be called from didReceive Notification Response or openURL",
                    f"{DEFAULT_INDENT}NSLog(@\"Smartech: Handling deeplink: %@\", deeplinkURLString);",
                    f"{DEFAULT_INDENT}// SmartechBasePlugin is typically for Cordova/React Native. Use direct SDK call for native:",
                    f"{DEFAULT_INDENT}// [[Smartech sharedInstance] handleDeeplinkWithURL:url andCustomPayload:notificationPayload]; // Adjust based on actual SDK method",
                    f"{DEFAULT_INDENT}// OR if SmartechBasePlugin is intended (e.g. for hybrid apps using native delegate):",
                    f"{DEFAULT_INDENT}// [SmartechBasePlugin handleDeeplinkActionWithURLString:deeplinkURLString andCustomPayload:notificationPayload];",
                    "}"
                 ]
            },
        ]

        # --- Process UNUserNotificationCenterDelegate Conformance ---
        needs_delegate = any(m.get('requires_delegate', False) for m in methods_to_process)
        delegate_added = False
        if needs_delegate:
            lines, delegate_added = add_uncenterdelegate_if_needed(lines, language)
            if delegate_added: made_changes = True


        # --- Process Each Method ---
        for method_config in methods_to_process:
            # Special case for didFinishLaunching: use its specific marker
            current_marker = method_config['marker']
            if method_config['name'] == 'didFinishLaunchingWithOptions':
                 # Find bounds using the more specific patterns
                 sig_idx_launch, end_idx_launch = find_method_bounds(lines, language, [re.compile(p) for p in method_config.get(f'{language}_patterns', [])])
                 # Check for the specific start marker within these bounds
                 if sig_idx_launch != -1 and end_idx_launch != -1 and check_marker_within_bounds(lines, SMARTECH_DID_FINISH_LAUNCHING_MARKER_START, sig_idx_launch, end_idx_launch):
                      print(f"   Skipping {method_config['name']} as start marker is present.")
                      continue # Skip if marker already exists

            # Process other methods or didFinishLaunching if marker wasn't present
            lines, modified = add_or_update_method(lines, language, method_config)
            if modified:
                 made_changes = True
                 # If a method requiring the delegate was *added*, re-check conformance
                 # This is slightly redundant if checked before, but safe
                 if method_config['add_if_missing'] and method_config.get('requires_delegate', False):
                     lines, _ = add_uncenterdelegate_if_needed(lines, language) # Ignore return value here


        # --- Write changes back if any were made ---
        if made_changes:
            print(f"\n   Writing modified AppDelegate back to file...")
            with open(app_delegate_file_path, 'w', encoding='utf-8') as file:
                file.writelines(lines)
            print(f"   Successfully modified AppDelegate.")
        else:
            print(f"\n   No code changes required in AppDelegate based on checks.")
            # Optionally remove backup if no changes were needed
            # try: os.remove(backup_ad_path) except OSError: pass


    except Exception as e:
        print(f"\nAn unexpected error occurred while modifying AppDelegate: {e}")
        import traceback
        traceback.print_exc() # Print detailed traceback for debugging
        print("Attempting to restore AppDelegate from backup...")
        overall_success = False # Mark as failed
        try:
            if os.path.exists(backup_ad_path):
                 with open(backup_ad_path, 'r', encoding='utf-8') as f_read, \
                      open(app_delegate_file_path, 'w', encoding='utf-8') as f_write:
                     f_write.write(f_read.read())
                 print("   AppDelegate restored from backup.")
            else:
                 print("   Error: Backup file not found. Cannot restore.")
        except Exception as restore_e:
            print(f"   CRITICAL: Failed to restore AppDelegate from backup: {restore_e}. Please restore manually from {backup_ad_path}")

    # Return True only if no exceptions occurred during the main try block
    return overall_success and made_changes


# --- Main Script Logic --- (Modified to call new AppDelegate function)
def main():
    print("Starting Smartech/Hansel project configuration script...")
    current_date_str = "May 6, 2025" # Using the fixed date from original script
    print(f"Current date: {current_date_str}")

    # --- Find Project Files ---
    plist_path = find_info_plist(EXCLUDE_DIRS)
    app_delegate_details_dict = find_app_delegate_details(EXCLUDE_DIRS)

    app_delegate_name = None
    app_delegate_file_path = None
    app_delegate_language = None
    app_entry_type = "Unknown"

    if app_delegate_details_dict:
        if 'error' in app_delegate_details_dict:
             print(f"\n>>> App Entry Point Search Error: {app_delegate_details_dict['error']} <<<")
             if "Python 3.5+" in app_delegate_details_dict.get('error',''): sys.exit(1)
        else:
            app_delegate_name = app_delegate_details_dict.get('name')
            app_delegate_file_path = app_delegate_details_dict.get('path')
            app_delegate_language = app_delegate_details_dict.get('language')
            if app_delegate_name and app_delegate_file_path and app_delegate_language:
                if app_delegate_language == 'swiftui_app': app_entry_type = f"SwiftUI App Struct ({app_delegate_name})"
                else: app_entry_type = f"AppDelegate ({app_delegate_name}, {app_delegate_language})"
                print(f"\n>>> Found App Entry Point: {app_entry_type} <<<")
                print(f"    Path: {app_delegate_file_path}")
            else: app_entry_type = "Incompletely Identified"
    else: app_entry_type = "Not Found"

    if not plist_path:
        print("\nScript aborted: Could not find a suitable Info.plist file.")
        sys.exit(1)

    # --- Get User Configuration ---
    smartech_user_data = get_smartech_keys_from_user()
    if not smartech_user_data:
        print("\nScript aborted: Smartech configuration is required and was not provided/cancelled.")
        sys.exit(1)

    hansel_user_data, user_opted_for_hansel = get_hansel_keys_from_user()
    if user_opted_for_hansel and not hansel_user_data:
         print("\nWarning: You indicated you use Hansel, but cancelled the key input. Hansel configuration will be skipped.")
         user_opted_for_hansel = False

    # --- Modify Info.plist ---
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
        if 'SmartechKeys' not in plist_data or plist_data['SmartechKeys'] != smartech_user_data:
            plist_data['SmartechKeys'] = smartech_user_data
            keys_added_or_updated_plist.append("SmartechKeys"); plist_modified = True
        if user_opted_for_hansel and hansel_user_data:
             if 'HanselKeys' not in plist_data or plist_data['HanselKeys'] != hansel_user_data:
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
            print("Info.plist already contains the necessary SDK key configurations.")

    except Exception as e:
        print(f"Error modifying Info.plist: {e}")
        print("Attempting to restore Info.plist from backup...")
        try:
            if os.path.exists(backup_plist_path):
                 with open(backup_plist_path, 'rb') as f_read, open(plist_path, 'wb') as f_write: f_write.write(f_read.read())
                 print("Info.plist restored from backup.")
            else: print("Error: Backup file for Info.plist not found.")
        except Exception as restore_e: print(f"CRITICAL: Failed to restore Info.plist from backup: {restore_e}.")
        print("Script aborted due to Info.plist modification error.")
        sys.exit(1)


    # --- Modify AppDelegate / Provide Instructions ---
    appdelegate_modified = False
    if app_delegate_file_path and app_delegate_language in ['swift', 'objc']:
        # Call the new comprehensive modification function
        appdelegate_modified = modify_app_delegate(
            app_delegate_file_path,
            app_delegate_language,
            user_opted_for_hansel and bool(hansel_user_data) # Pass hansel flag
            )
        if not appdelegate_modified:
             # Error messages are printed inside modify_app_delegate
             print("\nAppDelegate modification process encountered errors or made no changes.")
             # Backup file is preserved in case of errors inside modify_app_delegate

    elif app_delegate_language == 'swiftui_app':
        # Instructions for SwiftUI are now more complex
        print("\n--- Manual Integration Required (SwiftUI App) ---")
        print("Detected a SwiftUI App struct. Automatic code insertion is not supported for this structure.")
        print("You need to manually integrate the Smartech/Hansel SDK initialization AND required delegate methods.")
        print("1. Create an AppDelegate class (e.g., MyAppDelegate) conforming to `UIApplicationDelegate` and `UNUserNotificationCenterDelegate`.")
        print("2. Add the Smartech/Hansel initialization code within `application(_:didFinishLaunchingWithOptions:)`.")
        print("3. Implement the necessary delegate methods:")
        print("   - `application(_:didRegisterForRemoteNotificationsWithDeviceToken:)` -> call Smartech")
        print("   - `application(_:didFailToRegisterForRemoteNotificationsWithError:)` -> call Smartech")
        print("   - `userNotificationCenter(_:willPresent:withCompletionHandler:)` -> call Smartech, then completionHandler")
        print("   - `userNotificationCenter(_:didReceive:withCompletionHandler:)` -> call Smartech, then completionHandler")
        print("   - `application(_:open:options:)` -> call Smartech, handle return value/existing code")
        print("4. Add the `handleDeeplinkAction` helper function if needed.")
        print("5. Use `@UIApplicationDelegateAdaptor(MyAppDelegate.self) var appDelegate` in your App struct.")
        print("Refer to Smartech documentation for detailed native integration steps, then apply them within the delegate class.")
    else:
        print("\n--- Manual Integration Required (AppDelegate Not Found/Unsupported) ---")
        print("Could not find a standard AppDelegate file or the language is not supported for automatic code insertion.")
        print("Please add the required Smartech/Hansel SDK initialization AND necessary delegate methods manually.")
        # You could list the required methods here again as a reminder

    # --- Final Summary ---
    print("\n--- Script Finished ---")
    # if plist_modified:
    #      print(f"✅ Info.plist ({plist_path}) was modified.")
    #      print(f"   Backup created at: {backup_plist_path}")
    # else:
    #      print(f"ℹ️ Info.plist ({plist_path}) was checked but not modified.")

    if app_delegate_file_path and app_delegate_language in ['swift', 'objc']:
         if appdelegate_modified:
             print(f"✅ AppDelegate ({app_delegate_file_path}) was modified.")
             print(f"   Backup created at: {app_delegate_file_path + '.backup'}")
             print("   🚨 PLEASE REVIEW THE APPDELEGATE FILE FOR CORRECTNESS! 🚨")
         else:
             print(f"ℹ️ AppDelegate ({app_delegate_file_path}) modification attempt finished, but no changes were written (either due to errors or code already present).")
             print(f"   Backup remains at: {app_delegate_file_path + '.backup'}")
    elif app_delegate_language == 'swiftui_app' or not app_delegate_file_path:
         print(f"ℹ️ Automatic AppDelegate modification was skipped (Reason: {app_entry_type}). See instructions above for manual steps.")


if __name__ == "__main__":
    if sys.version_info < (3, 6): # Regex improvements might benefit from 3.6+
         print("Warning: This script is best run with Python 3.6 or newer.")
    main()