# check_mem_util.ps1
A lightweight PowerShell script to monitor RAM usage. It checks the current RAM usage and returns a status based on user-defined warning and critical thresholds.
Build for Icinga / Icinga2 / Nagios monitoring system.

## 📋 Description

This script retrieves memory usage data using WMI, calculates the percentage of memory in use, and returns:

- ✅ **OK** – if usage is below the warning threshold  
- ⚠️ **WARNING** – if usage exceeds the warning threshold  
- ❌ **CRITICAL** – if usage exceeds the critical threshold  

The script is ideal for integration into monitoring systems (like Nagios, Icinga, or custom dashboards), as it uses standard exit codes:

- `0` = OK  
- `1` = WARNING  
- `2` = CRITICAL  

## 🚀 Usage

```powershell
.\check_mem_util.ps1 [-WARN <int>] [-CRIT <int>]
```

### Parameters

| Parameter | Type | Description | Default |
|----------|------|-------------|---------|
| `-WARN`  | int  | Warning threshold for memory usage (%) | 80 |
| `-CRIT`  | int  | Critical threshold for memory usage (%) | 90 |

### Example

```powershell
.\check_mem_util.ps1 -WARN 75 -CRIT 90
```

This example triggers a WARNING at 75% usage and CRITICAL at 90%.

## 📊 Output

Output includes:

- Current memory utilization in percent
- Free memory in MB
- Total memory in MB

Example:

```
CRITICAL: Memory utilization is 91.35 %. Free Memory is 1024 Mb from 8192 Mb
```

## ✅ Requirements

- PowerShell 4.0 or higher  
- Windows with WMI enabled

## 🔄 Exit Codes

| Code | Status   |
|------|----------|
| `0`  | OK       |
| `1`  | WARNING  |
| `2`  | CRITICAL |


## License

This project is licensed under the GNU General Public License v2.0 or later. See the [LICENSE](LICENSE) file for details.

## 👤 Author

Developed by chr0w94.

