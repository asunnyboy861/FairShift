# Price Configuration

## Monetization Model
Auto-renewable Subscription (IAP Required)

## Subscription Group
Group Name: FairShift Pro

### Tier 0: Free (Always Available)
- **Type**: Free (limited features)
- **Features**: Basic task tracking, single user, limited Fair Play cards (10 cards), basic completion logging
- **Purpose**: User acquisition, trial experience

### Tier 1: Monthly Subscription
- **Reference Name**: FairShift Pro Monthly
- **Product ID**: com.zzoutuo.FairShift.pro.monthly
- **Price**: $3.99 (USD)
- **Subscription Period**: 1 Month
- **Localization (English US)**:
  - Display Name: FairShift Pro Monthly (max 35 chars)
  - Description: Unlock full Fair Play deck and insights (max 55 chars)

### Tier 2: Yearly Subscription
- **Reference Name**: FairShift Pro Yearly
- **Product ID**: com.zzoutuo.FairShift.pro.yearly
- **Price**: $24.99 (USD)
- **Subscription Period**: 1 Year
- **Localization (English US)**:
  - Display Name: FairShift Pro Yearly (max 35 chars)
  - Description: Save 48% with annual plan (max 55 chars)

### Tier 3: Lifetime (Non-consumable)
- **Include**: YES — App has NO API costs or usage-based costs
- **Reference Name**: FairShift Pro Lifetime
- **Product ID**: com.zzoutuo.FairShift.pro.lifetime
- **Price**: $59.99 (USD)
- **Type**: Non-consumable (One-time, no renewal)
- **Localization (English US)**:
  - Display Name: FairShift Pro Lifetime (max 35 chars)
  - Description: One-time purchase, forever access (max 55 chars)

## Free vs Pro Feature Comparison

| Feature | Free | Pro |
|---------|------|-----|
| Basic task tracking | ✅ | ✅ |
| Single user | ✅ | ✅ |
| Fair Play Card Deck | 10 cards | 100+ cards |
| Partner sync | ❌ | ✅ |
| Mental Load Map | ❌ | ✅ |
| Partnership Score | Basic | Full |
| Monthly Fair Report | ❌ | ✅ |
| Pattern Radar | ❌ | ✅ |
| Smart Nudge | ❌ | ✅ |
| Photo proof logging | ❌ | ✅ |
| Ownership breakdown | ❌ | ✅ |

## App Store Connect Setup Instructions
1. Go to App Store Connect → Your App → Subscriptions
2. Create Subscription Group: "FairShift Pro"
3. Add subscriptions with above Product IDs
4. Configure localizations for each
5. Submit for review

## IAP Compliance Checklist (REQUIRED for Subscription Apps)
- [ ] Paywall displays subscription names
- [ ] Paywall displays subscription durations
- [ ] Dynamic pricing from StoreKit (no hardcoded prices)
- [ ] Renewal terms displayed: "Subscription automatically renews unless canceled..."
- [ ] Cancellation instructions displayed
- [ ] Free trial clause displayed (if applicable)
- [ ] Restore Purchases button implemented
- [ ] Privacy Policy link on paywall
- [ ] Terms of Use link on paywall
- [ ] NO dark patterns (no auto-selecting expensive options)
- [ ] Lifetime tier included (app has no API/usage costs)
