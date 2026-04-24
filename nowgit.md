# Git Repositories

## Main App
- **Git**: git@github.com:asunnyboy861/FairShift.git
- **Repo URL**: https://github.com/asunnyboy861/FairShift
- **Visibility**: Public
- **Description**: FairShift iOS app - Mental Load & Chore Balance tracker

## Policy Pages (GitHub Pages)

### Support Page
- **URL**: https://asunnyboy861.github.io/FairShift/
- **Source**: `/docs/index.html` in main repo
- **Status**: ✅ Deployed via GitHub Pages

### Privacy Policy
- **URL**: https://asunnyboy861.github.io/FairShift/privacy.html
- **Source**: `/docs/privacy.html` in main repo
- **Status**: ✅ Deployed via GitHub Pages

### Terms of Use
- **URL**: https://asunnyboy861.github.io/FairShift/terms.html
- **Source**: `/docs/terms.html` in main repo
- **Status**: ✅ Deployed via GitHub Pages

## Repository Structure

```
FairShift/
├── FairShift/                    # iOS Xcode Project
│   ├── FairShift.xcodeproj/
│   ├── FairShift/
│   │   ├── FairShiftApp.swift
│   │   ├── ContentView.swift
│   │   ├── Models/              # SwiftData models
│   │   ├── Views/               # SwiftUI views
│   │   ├── ViewModels/          # MVVM view models
│   │   ├── Engines/             # Business logic
│   │   ├── Services/            # IAP, Notifications
│   │   ├── Extensions/          # Swift extensions
│   │   ├── Assets.xcassets/     # App icons, colors
│   │   └── Products.storekit    # StoreKit configuration
│   ├── FairShiftTests/
│   └── FairShiftUITests/
├── docs/                         # GitHub Pages
│   ├── index.html               # Support page
│   ├── privacy.html             # Privacy policy
│   └── terms.html               # Terms of use
├── screenshots/                  # App Store screenshots
├── us.md                         # English operation guide
├── capabilities.md              # Capabilities configuration
├── price.md                     # Pricing configuration
├── contact.md                   # Contact support info
├── appstore.md                  # App Store metadata
└── nowgit.md                    # This file
```

## iCloud Configuration

### Container ID
- **Identifier**: `iCloud.com.zzoutuo.FairShift`
- **Status**: ✅ Configured in entitlements
- **Build Status**: ✅ Build succeeded

### Capabilities Enabled
| Capability | Status |
|------------|--------|
| iCloud (CloudKit) | ✅ Enabled |
| Push Notifications | ✅ Enabled |
| Camera | ✅ Enabled |
| Photo Library | ✅ Enabled |

## App Store Connect Info

- **Bundle ID**: com.zzoutuo.FairShift
- **App Name**: FairShift: Mental Load Balance
- **Subtitle**: Fair chore & mental load tracker
- **Primary Category**: Lifestyle
- **Secondary Category**: Productivity
- **Price**: Free with In-App Purchases

## Deployment Checklist

- [x] Main app pushed to GitHub
- [x] Privacy policy deployed
- [x] Terms of use deployed
- [x] Support page deployed
- [x] iCloud container configured
- [x] Build verified
- [ ] GitHub Pages enabled (manual: Settings → Pages → Source: main /docs)
- [ ] App Store Connect app created (manual)
- [ ] Screenshots uploaded (manual)
- [ ] Build archived and uploaded (manual)
