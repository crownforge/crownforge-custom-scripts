# Crownforge Custom Scripts (Physgun edition)

A modular set of scripts to manage Minecraft worlds hosted on Physgun, including automated backups, retention pruning, and log management. Designed for containerized servers without SSH access.

---

## 📁 Folder Structure

```
custom/
├── backups/
│   └── YYYYMMDD/
│       ├── world.tar.gz
│       ├── world_nether.tar.gz
│       └── world_the_end.tar.gz
├── logs/
│   └── YYYYMMDD/
│       └── backup.log
└── scripts/
    ├── backup.sh
    ├── prune_backups.sh
    └── prune_logs.sh
```

---

## 🧩 Script Descriptions

### `backup.sh`
-   **Description:** Creates a daily backup of the specified Minecraft world dimensions.
-   **Functionality:**
    -   Creates a timestamped folder in `custom/backups/YYYYMMDD/`.
    -   Compresses `world/`, `world_nether/`, and `world_the_end/` into individual `tar.gz` files.
    -   Temporarily disables world saving via `screen` to prevent data corruption during backup.
    -   Logs all operations to `custom/logs/YYYYMMDD/backup.log`.

### `prune_backups.sh`
-   **Description:** Manages backup retention by deleting old backups.
-   **Functionality:**
    -   Removes any backup folders under `custom/backups/` that are older than 5 days.

### `prune_logs.sh`
-   **Description:** Manages log retention by deleting old log files.
-   **Functionality:**
    -   Removes any log folders under `custom/logs/` that are older than 30 days.

---

## ⏰ Cron Setup

If your server supports `cron`, you can automate these scripts by adding the following to your crontab (`crontab -e`):

```cron
# Daily world backup at 3:00 AM
0 3 * * * /home/container/custom/scripts/backup.sh >> /dev/null 2>&1

# Daily pruning of old backups at 4:05 AM
5 4 * * * /home/container/custom/scripts/prune_backups.sh >> /dev/null 2>&1

# Weekly pruning of old logs on Sunday at 4:10 AM
10 4 * * 0 /home/container/custom/scripts/prune_logs.sh >> /dev/null 2>&1
```
If `cron` is not available, use your hosting panel's scheduler to run the scripts at similar intervals.

---

## 🛡 Best Practices

-   **Data Integrity:** Backups are taken with world saving temporarily disabled to prevent corruption.
-   **Retention Policy:**
    -   Backups are kept for **5 days**.
    -   Logs are kept for **30 days**.
-   **Modular Backups:** Each world dimension is compressed into a separate file for easier restoration of individual worlds.

---

## 🧠 License

This project is licensed under the MIT License or is in the public domain (Unlicense). You are free to use, modify, redistribute, and contribute.

---

## ✉️ Author

Created by a nerd who didn’t want to deal with griefing.
