# Windows Optimization Scripts

This repository contains PowerShell scripts to optimize Windows performance and privacy by disabling unnecessary features and telemetry. The scripts are based on the manual steps provided by Enzo Thulio from the [1155doET YouTube channel](https://www.youtube.com/@1155doET).

## Credits

- **Author**: Wellington Falcão ([wellingtonfalcao@gmail.com](mailto:wellingtonfalcao@gmail.com))
- **Original Inspiration**: Enzo Thulio (1155doET)

## Scripts

### 1. Optimization Script (`debloat-windows.ps1`)

This script applies various optimizations to Windows by disabling telemetry, cloud content, background apps, and other features that may impact performance and privacy.

#### Features Disabled/Configured:

- Telemetry and diagnostic data
- Application compatibility telemetry
- Cloud content and consumer features
- Location and sensors
- Automatic updates (configured to notify before download)
- Microsoft Edge prelaunch and tab preloading
- Cortana and cloud search
- Background apps
- Error reporting
- Settings sync
- Advertising ID
- Activity feed

#### How to Use

1. Download the script `disable-policies.ps1`.
2. Right-click on the script and select "Run with PowerShell" or run in an elevated PowerShell session.
3. Restart your computer after the script completes.

**Note**: Run the script as Administrator.

### 2. Restoration Script (`restore-defaults.ps1`)

This script restores the default Windows settings by removing the policies set by the optimization script.

#### How to Use

1. Download the script `restore-defaults.ps1`.
2. Right-click on the script and select "Run with PowerShell" or run in an elevated PowerShell session.
3. Restart your computer after the script completes.

**Note**: Run the script as Administrator.

## Disclaimer

Use these scripts at your own risk. The authors are not responsible for any issues that may arise from using these scripts. It is recommended to back up your system before making any changes.

## License

This project is open source and available under the [MIT License](LICENSE).