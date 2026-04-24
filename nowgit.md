# Git Repositories

## Main App
- **Git**: git@github.com:asunnyboy861/FairShift.git
- **Repo URL**: https://github.com/asunnyboy861/FairShift
- **Visibility**: Public
- **Description**: FairShift iOS app - Mental Load & Chore Balance tracker

## Policy Pages (GitHub Pages)

### Support Page
- **Repo**: git@github.com:asunnyboy861/FairShift-support.git
- **Repo URL**: https://github.com/asunnyboy861/FairShift-support
- **GitHub Pages URL**: https://asunnyboy861.github.io/FairShift-support/
- **Status**: Deployed

### Privacy Policy
- **Repo**: git@github.com:asunnyboy861/FairShift-privacy.git
- **Repo URL**: https://github.com/asunnyboy861/FairShift-privacy
- **GitHub Pages URL**: https://asunnyboy861.github.io/FairShift-privacy/
- **Status**: Deployed

### Terms of Use
- **Repo**: git@github.com:asunnyboy861/FairShift-terms.git
- **Repo URL**: https://github.com/asunnyboy861/FairShift-terms
- **GitHub Pages URL**: https://asunnyboy861.github.io/FairShift-terms/
- **Status**: Deployed

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
├── screenshots/                  # App Store screenshots
├── us.md                         # English operation guide
├── capabilities.md              # Capabilities configuration
├── price.md                     # Pricing configuration
├── contact.md                   # Contact support info
├── keytext.md                   # App Store metadata
└── nowgit.md                    # This file
```

## iCloud Configuration

### Container ID
- **Identifier**: `iCloud.com.zzoutuo.FairShift`
- **Status**: Configured in entitlements
- **Build Status**: Build succeeded

### Capabilities Enabled
| Capability | Status |
|------------|--------|
| iCloud (CloudKit) | Enabled |
| Push Notifications | Enabled |
| Camera | Enabled |
| Photo Library | Enabled |

## App Store Connect Info

- **Bundle ID**: com.zzoutuo.FairShift
- **App Name**: FairShift: Mental Load Balance
- **Subtitle**: Fair chore & mental load tracker
- **Primary Category**: Lifestyle
- **Secondary Category**: Productivity
- **Price**: Free with In-App Purchases

## Deployment Checklist

- [x] Main app pushed to GitHub
- [x] Support page deployed to separate repo
- [x] Privacy policy deployed to separate repo
- [x] Terms of use deployed to separate repo
- [x] iCloud container configured
- [x] Build verified
- [ ] App Store Connect app created (manual)
- [ ] Screenshots uploaded (manual)
- [ ] Build archived and uploaded (manual)
