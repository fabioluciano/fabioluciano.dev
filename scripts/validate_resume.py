#!/usr/bin/env python3
"""
Resume validation script using official JSON Resume Schema.
Validates YAML resume files by converting them to JSON and validating against 
the official JSON Resume schema from https://github.com/jsonresume/resume-schema
"""

import sys
import json
import yaml
import argparse
from pathlib import Path
from urllib.request import urlopen
from urllib.error import URLError

try:
    import jsonschema
    from jsonschema import validate, ValidationError, SchemaError
except ImportError:
    print("❌ Error: jsonschema package not found.")
    print("Install it with: pip install jsonschema")
    sys.exit(1)

# Official JSON Resume Schema URL
SCHEMA_URL = "https://raw.githubusercontent.com/jsonresume/resume-schema/master/schema.json"

def load_yaml_file(file_path):
    """Load YAML file and return parsed data."""
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            return yaml.safe_load(file)
    except yaml.YAMLError as e:
        print(f"❌ Error parsing YAML file {file_path}: {e}")
        return None
    except FileNotFoundError:
        print(f"❌ File not found: {file_path}")
        return None

def load_json_schema():
    """Load JSON Resume schema from official URL."""
    try:
        with urlopen(SCHEMA_URL) as response:
            schema_data = json.loads(response.read().decode('utf-8'))
            return schema_data
    except URLError as e:
        print(f"❌ Error fetching schema from {SCHEMA_URL}: {e}")
        print("💡 Tip: Check your internet connection")
        return None
    except json.JSONDecodeError as e:
        print(f"❌ Error parsing JSON schema: {e}")
        return None

def merge_yaml_data(common_data, lang_data):
    """Merge common.yaml with language-specific YAML data."""
    def deep_merge(base, override):
        """Deep merge two dictionaries."""
        if not isinstance(base, dict) or not isinstance(override, dict):
            return override
        
        result = base.copy()
        for key, value in override.items():
            if key in result and isinstance(result[key], dict) and isinstance(value, dict):
                result[key] = deep_merge(result[key], value)
            else:
                result[key] = value
        return result
    
    return deep_merge(common_data or {}, lang_data or {})

def validate_resume(resume_data, schema_data):
    """Validate resume data against JSON Resume schema."""
    try:
        validate(instance=resume_data, schema=schema_data)
        return True, None
    except ValidationError as e:
        return False, f"Validation error: {e.message}"
    except SchemaError as e:
        return False, f"Schema error: {e.message}"

def main():
    parser = argparse.ArgumentParser(
        description='Validate resume YAML files against JSON Resume schema',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s data/resume.en.yaml               # Validate English resume
  %(prog)s data/resume.ptbr.yaml             # Validate Portuguese resume  
  %(prog)s data/resume.en.yaml data/resume.ptbr.yaml  # Validate both
  %(prog)s --all                             # Validate all resume files

The script automatically merges common.yaml with language-specific YAML files.
        """
    )
    
    parser.add_argument(
        'files', 
        nargs='*', 
        help='Resume YAML files to validate'
    )
    
    parser.add_argument(
        '--all', 
        action='store_true',
        help='Validate all resume YAML files in data/ directory'
    )
    
    parser.add_argument(
        '--common', 
        default='data/common.yaml',
        help='Path to common YAML file (default: data/common.yaml)'
    )
    
    args = parser.parse_args()
    
    # Determine files to validate
    if args.all:
        data_dir = Path('data')
        files = list(data_dir.glob('resume.*.yaml'))
        if not files:
            print("❌ No resume YAML files found in data/ directory")
            sys.exit(1)
    elif args.files:
        files = [Path(f) for f in args.files]
    else:
        parser.print_help()
        sys.exit(1)
    
    print("📋 JSON Resume Schema Validation")
    print(f"🌐 Using schema: {SCHEMA_URL}")
    print()
    
    # Load JSON Resume schema
    print("🔄 Loading JSON Resume schema...")
    schema_data = load_json_schema()
    if not schema_data:
        sys.exit(1)
    print("✅ Schema loaded successfully")
    
    # Load common data
    common_data = {}
    if Path(args.common).exists():
        print(f"🔄 Loading common data from {args.common}...")
        common_data = load_yaml_file(args.common)
        if common_data is None:
            sys.exit(1)
        print("✅ Common data loaded")
    else:
        print(f"⚠️  Common file {args.common} not found, proceeding without merge")
    
    print()
    
    # Validate each file
    all_valid = True
    for file_path in files:
        print(f"🔄 Validating {file_path}...")
        
        # Load language-specific data
        lang_data = load_yaml_file(file_path)
        if lang_data is None:
            all_valid = False
            continue
        
        # Merge with common data
        merged_data = merge_yaml_data(common_data, lang_data)
        
        # Validate against schema
        is_valid, error_msg = validate_resume(merged_data, schema_data)
        
        if is_valid:
            print(f"✅ {file_path}: Valid JSON Resume format")
        else:
            print(f"❌ {file_path}: {error_msg}")
            all_valid = False
        
        print()
    
    if all_valid:
        print("🎉 All resume files are valid!")
        sys.exit(0)
    else:
        print("💥 Some resume files have validation errors")
        sys.exit(1)

if __name__ == '__main__':
    main()