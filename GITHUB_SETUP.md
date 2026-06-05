# GitHub Setup for Geronimmo Planner (Portfolio Ready)

## Step 1: Create GitHub Repository
1. Go to https://github.com/new (log in or create free account)
2. Repository name: geronimmo-planner (or your choice)
3. Description: Cross-platform planner app built with Flutter (tasks, calendar, dashboard, multilingual)
4. Public or Private (Public recommended for portfolio)
5. Do NOT initialize with README (we already have one)
6. Create repository

## Step 2: Connect and Push (run these in PowerShell)
cd D:\Geronimmo_Planner

# Replace YOUR_USERNAME with your GitHub username
git remote add origin https://github.com/YOUR_USERNAME/geronimmo-planner.git

# Push the code (with all the nice commit history showing active development)
git branch -M main
git push -u origin main

## After push:
- Your repo will have 8+ commits showing you actively developed features.
- Perfect for resume: "Built and actively maintained Geronimmo Planner - full-stack Flutter app"
- Link it in your LinkedIn/GitHub profile.

If you get auth error, use a Personal Access Token (classic) with repo scope instead of password.
Create token at: https://github.com/settings/tokens
Then use it as password when prompted.
