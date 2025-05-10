# 🔔 Imba Notifications

A lightweight, customizable notification system for Imba applications with smooth animations and a clean user interface.

## ✨ Features

- 🔔 Four notification types: success, info, caution, and error
- 🎭 Smooth animations for displaying and hiding notifications
- 👆 Click-to-expand functionality for detailed information
- 🎨 Configurable display durations and customizable styling
- 🖌️ Modern glass-morphism styling with light/dark mode support by default
- 🧩 Easy integration with any Imba application

## 📦 Installation

```bash
# Using npm
npm install imba-notifications

# Using Bun
bun add imba-notifications
```

## 🚀 Quick Start

```imba
import { Notifications, ShowNotifications } from 'imba-notifications'

# Create a notifications instance
const notify = new Notifications!
# Define the hint over the progress bar (could be empty)
notify.hint = 'Click the message to avoid timeout and view details'

# In your main app or component
tag App
    <self>
        <ShowNotifications state=notify>
        <button @click=notify.success('Success!', 'Operation completed successfully')> "Show Success"
        <button @click=notify.info('Info', 'This is an informational message')> "Show Info"
        <button @click=notify.caution('Caution', 'Proceed with care')> "Show Caution"
        <button @click=notify.error('Error', 'Something went wrong')> "Show Error"
```

## 📘 API Reference

### Notifications Class

#### Properties

- `duration` - Object containing animation durations (in milliseconds)
  - `show` - Time to animate in (default: 500ms)
  - `display` - Time to remain visible (default: 15000ms)
  - `hide` - Time to animate out (default: 500ms)
  - `wipe` - Time to remove from DOM (default: 500ms)
- `hint` - Text shown at the bottom of notifications (default is empty)

#### Methods

```imba
# Display a success notification
notify.success(header, text, details = '')

# Display an info notification
notify.info(header, text, details = '')

# Display a caution notification
notify.caution(header, text, details = '')

# Display an error notification
notify.error(header, text, details = '')
```

Parameters:
- `header` (string) - Bold title text for the notification
- `text` (string) - Body text for the notification (appears only when the notification is clicked)
- `details` (string, optional) - Additional details shown when the notification is clicked

### ShowNotifications Component

The `ShowNotifications` tag is responsible for rendering notifications from a given Notifications class instance.

```imba
<ShowNotifications state=notifications>
```

## ⚙️ Customization

You can customize the duration settings:

```imba
const notifications = new Notifications!

# Customize durations (in milliseconds)
notifications.duration = {
    show: 300      # Animation in
    display: 5000  # Time visible
    hide: 300      # Animation out
    wipe: 300      # DOM removal
}

# Customize hint text
notifications.hint = 'Click for more details'
```

## 🎨 Styling

The notifications use Imba's CSS syntax with light/dark mode support. You can customize the appearance through tag inheritance and by redefining CSS properties of existing classes.

### 🧬 Tag Inheritance

To customize the notification component, create a new tag that inherits from the base component:

```imba
import { ShowNotifications } from 'imba-notifications'

# Create a custom notifications component
tag CustomNotifications < ShowNotifications
    # Override CSS definitions
    css
        .container
            rd:10px # Custom border radius
            bd:2px solid light-dark(teal, cyan) # Custom border
            bgc:light-dark(teal/10, cyan/20) # Custom background
        
        .header-text
            fs:16px # Custom font size
            fw:bold # Custom font weight
        
        .header-icon-success
            fill:light-dark(green, lime) # Custom success color
        
        .body-text
            fs:14px # Custom body text size
            c:light-dark(black/90, white/90) # Custom text color
        
        # Override animation if needed
        .show
            animation: custom-show var(--show) ease
            @keyframes custom-show
                from transform: translateY(-100%)
                to transform: translateY(0)

# Use your custom component
tag App
    const notifications = new Notifications()
    <self>
        <CustomNotifications state=notifications>
        <button @click=notifications.success('Custom', 'This uses custom styling')> "Show Notification"
```

### 🎯 Modifying Specific Classes

To target specific notification types with different styles:

```imba
tag CustomNotifications < ShowNotifications
    css
        # Success notifications
        .container:has(.header-icon-success)
            bgc:light-dark(green/10, lime/10)
            bd:1px solid light-dark(green/30, lime/30)
        
        # Error notifications
        .container:has(.header-icon-error)
            bgc:light-dark(red/10, crimson/10)
            bd:1px solid light-dark(red/30, crimson/30)
```

### 📋 Available CSS Classes

The notification component uses the following CSS classes that you can customize:

- `.container` - Main notification message container
- `.header-container` - Header section containing icon, title and close button (cross icon)
- `.header-text` - Notification title text
- `.header-icon` - Base class for all notification type icons
- `.header-icon-success`, `.header-icon-info`, `.header-icon-caution`, `.header-icon-error` - Type-specific icon classes
- `.header-close` - Close button
- `.body-container` - Container for notification body (shown when clicked)
- `.body-text` - Main notification message text
- `.body-details` - Detailed information container
- `.footer` - Footer containing the hint text and progress bar
- `.show`, `.hide`, `.wipe` - Animation state classes

## 👥 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.