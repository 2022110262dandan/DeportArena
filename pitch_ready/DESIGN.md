---
name: Pitch Ready
colors:
  surface: '#f8f9ff'
  surface-dim: '#d1dbec'
  surface-bright: '#f8f9ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#eef4ff'
  surface-container: '#e5eeff'
  surface-container-high: '#dfe9fa'
  surface-container-highest: '#d9e3f4'
  on-surface: '#121c28'
  on-surface-variant: '#3d4a3d'
  inverse-surface: '#27313e'
  inverse-on-surface: '#eaf1ff'
  outline: '#6d7b6c'
  outline-variant: '#bccbb9'
  surface-tint: '#006e2f'
  primary: '#006e2f'
  on-primary: '#ffffff'
  primary-container: '#22c55e'
  on-primary-container: '#004b1e'
  inverse-primary: '#4ae176'
  secondary: '#006591'
  on-secondary: '#ffffff'
  secondary-container: '#39b8fd'
  on-secondary-container: '#004666'
  tertiary: '#555f6f'
  on-tertiary: '#ffffff'
  tertiary-container: '#a2acbe'
  on-tertiary-container: '#36404f'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#6bff8f'
  primary-fixed-dim: '#4ae176'
  on-primary-fixed: '#002109'
  on-primary-fixed-variant: '#005321'
  secondary-fixed: '#c9e6ff'
  secondary-fixed-dim: '#89ceff'
  on-secondary-fixed: '#001e2f'
  on-secondary-fixed-variant: '#004c6e'
  tertiary-fixed: '#d9e3f6'
  tertiary-fixed-dim: '#bdc7d9'
  on-tertiary-fixed: '#121c2a'
  on-tertiary-fixed-variant: '#3d4756'
  background: '#f8f9ff'
  on-background: '#121c28'
  surface-variant: '#d9e3f4'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 48px
    fontWeight: '700'
    lineHeight: 56px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.01em
  headline-lg-mobile:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 32px
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  label-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
  label-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  unit: 4px
  container-max: 1280px
  gutter: 24px
  margin-mobile: 16px
  margin-desktop: 32px
---

## Brand & Style
The design system is engineered for a high-performance SaaS environment tailored to sports management. The brand personality is energetic yet highly organized, bridging the gap between the physical intensity of football and the digital precision of a booking platform. 

The aesthetic follows a **Corporate / Modern** style with a focus on high-utility card-based layouts. It prioritizes clarity and speed of use, utilizing significant white space to reduce cognitive load during the booking process. The emotional response should be one of reliability and "game-day" excitement, achieved through a blend of professional slate tones and a vibrant, grass-inspired primary green.

## Colors
The palette is dominated by "Vibrant Football Green," used strategically for primary actions, success states, and pitch-related indicators. "Light Blue" serves as an interactive accent, specifically for secondary calls-to-action, links, and informational highlights. 

The neutral scale utilizes "Dark Grey" for high-contrast text and "Slate Grey" for secondary information and borders. The background is a very light grey to allow white cards to pop with subtle elevation. Success, warning, and error states should derive from the primary green and standard red/amber tones, ensuring the green remains the hero of the interface.

## Typography
This design system utilizes **Inter** for its exceptional legibility and systematic feel. Headlines use a bold weight with slight negative letter-spacing to appear more impactful and "athletic." Body text is kept clean and open. 

Label styles are used for status chips and metadata, often employing a semibold weight to ensure they remain legible even at small sizes. For mobile, headline sizes are scaled down to ensure content remains the focus without excessive scrolling.

## Layout & Spacing
The system employs a **Fluid Grid** model with a 12-column structure for desktop. A 4px baseline shift ensures all elements—from icons to line heights—align to a consistent vertical rhythm.

- **Desktop:** 12 columns, 24px gutters, 32px side margins.
- **Tablet:** 8 columns, 16px gutters, 24px side margins.
- **Mobile:** 4 columns, 16px gutters, 16px side margins.

Spacing between cards should be consistent at 24px to maintain the "airy" SaaS feel, while internal card padding should follow a 16px or 24px rule depending on the component's importance.

## Elevation & Depth
Depth is managed through **Ambient Shadows** and tonal layering. Surfaces do not use heavy borders; instead, they rely on soft, diffused shadows to indicate hierarchy.

- **Level 0 (Background):** #F9FAFB.
- **Level 1 (Cards/Sidebar):** White surface with a `0px 1px 3px rgba(0,0,0,0.1)` shadow.
- **Level 2 (Dropdowns/Modals):** White surface with a `0px 10px 15px rgba(0,0,0,0.1)` shadow.

Interactions (like hovering over a pitch card) should slightly increase the shadow spread and lift the element by 2px to provide tactile feedback.

## Shapes
The shape language is distinctly friendly yet professional. While the system uses a base roundedness of 8px (`0.5rem`), specific container elements like pitch cards and player profiles utilize `rounded-2xl` (1rem or 1.5rem) to emphasize the modern, approachable nature of the platform. Buttons and input fields should remain at `rounded-lg` (0.5rem) for a crisp, functional look.

## Components

### Buttons & Inputs
- **Primary Button:** Solid #22C55E with white text. On hover, darken by 10%.
- **Secondary Button:** Solid #0EA5E9 with white text.
- **Inputs:** White background, 1px border (#E5E7EB), focuses to a 2px #0EA5E9 ring.

### Metric Cards
Dashboard widgets featuring large display typography for numbers and a small Sparkline chart or percentage indicator in the corner. Icons (e.g., whistle, trophy, users) should be placed in a light-green circular background.

### Player Cards
Cards include a circular avatar, player name, and a "Status Chip."
- **Confirmed:** Green background, dark green text.
- **Pending:** Amber background, dark amber text.
- **Rejected:** Red background, dark red text.

### Team Containers
Two distinct card styles (Team A vs Team B). Use subtle color headers (Slate for Team A, Light Blue for Team B) to visually separate the rosters during a booking or match setup.

### Calendar & Time Pickers
Horizontal date scroller for mobile; full grid for desktop. Available slots use a light green ghost button style; selected slots use the solid Primary Green.

### Icons
Use a thin-stroke (2px) icon set. Key icons: `soccer-ball`, `clock`, `map-pin`, `users`, `calendar`, `credit-card`. Use icons to reinforce action labels and provide visual cues in the navigation.