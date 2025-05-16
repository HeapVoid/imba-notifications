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
import { Notifications } from 'imba-notifications'

# Create a notifications instance
const notify = new Notifications!
# Define the hint over the progress bar (could be empty)
notify.hint = 'Click the message to avoid timeout and view details'
# Mount notifications center separately from the main application tag
imba.mount <notifications-center state=notify>

# In your main app or component
tag App
    <self>
        <button @click=notify.success({header: 'Success!', text: 'Operation completed successfully'})> "Show Success"
        <button @click=notify.info({header: 'Info', text: 'This is an informational message'})> "Show Info"
        <button @click=notify.caution({header: 'Caution', text: 'Proceed with care'})> "Show Caution"
        <button @click=notify.error({header: 'Error', text: 'Something went wrong'})> "Show Error"

imba.mount <App>
```

## 📘 API Reference

### Notifications Class

#### Properties

- `duration` - Object containing animation durations (in milliseconds)
  - `show` - Time to animate in (default: 500ms)
  - `display` - Time to remain visible (default: 15000ms)
  - `hide` - Time to animate out (default: 500ms)
  - `wipe` - Time to remove from DOM (default: 500ms)
  - `expand` - Time to animate notification expanding on click (default: 200ms)
- `hint` - Text shown at the bottom of notifications (default is empty)
- `header` - Key to use for header text in the passed object (default is 'header') 
- `text` - Key to use for body text in the passed object (default is 'text')

#### Methods

```imba
# Display a success notification
notify.success({header: 'Success!', text: 'Operation completed successfully'}, details = '')

# Display an info notification
notify.info({header: 'Info', text: 'This is an informational message'}, details = '')

# Display a caution notification
notify.caution({header: 'Caution', text: 'Proceed with care'}, details = '')

# Display an error notification
notify.error({header: 'Error', text: 'Something went wrong'}, details = '')
```

Parameters:
- `message` (object) - should consist of two keys: `header` and `text` (or appropriate keys defined in `header` and `text` properties)
- `details` (string, optional) - Additional details shown when the notification is clicked

### NotificationsShow Component

The `<notifications-center>` tag is responsible for rendering notifications from a given Notifications class instance.

```imba
imba.mount <notifications-center state=notifications>
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
    expand: 100    # Expanding notification
}

# Customize hint text
notifications.hint = 'Click for more details'
```

## 🎨 Styling

The notifications use Imba's CSS syntax with light/dark mode support. You can customize the appearance through tag inheritance and by redefining CSS properties of existing classes.

### 🧬 Tag Inheritance

To customize the notification component, create a new tag that inherits from the base component:

```imba
import { Notifications } from 'imba-notifications'

# Create a custom notifications component
tag custom-notifications < notifications-center
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
const notifications = new Notifications!
imba.mount <custom-notifications state=notifications>

tag App
    <self>
        <button @click=notifications.success({header:'Custom', text:'This uses custom styling'})> "Show Notification"

imba.mount <App>
```

### 🎯 Modifying Globally

The built in selectors can be overridden globally the following way:

```imba
global css
    notifications-center@not(#_)
        .container
            rd:10px
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
- `.body-footer` - Used mainly as a bottom margin of the body
- `.timer` - The timeout containing the hint text and progress bar (before clicked)
- `.show`, `.hide`, `.wipe` - Animation state classes

## 🧰 Additional Function and Icons

The package exports additional utilities that developers can use in their applications:

### ⏲️ Timeout Function

A Promise-based timeout function for creating delays in async operations:

```imba
import { timeout } from 'imba-notifications'

# Usage in async functions
def myAsyncFunction
    # Do something
    await timeout(500) # Wait for 500ms
    # Continue execution
```

### 🎭 Icons

The package exports icons as SVG body that you can use in your application.

```imba
import { 
    icon-success, 
    icon-info, 
    icon-caution, 
    icon-error, 
    icon-close 
} from 'imba-notifications'

tag MyComponent
    <self>
        css d:hcc
        <svg viewBox="0 0 256 256"> 
            <{icon-success} [fill:emerald5]>
        <svg viewBox="0 0 256 256"> 
            css fill:green
            <{icon-info}>
        <svg viewBox="0 0 256 256"> 
            css fill:orange w:32px
            <{icon-caution}>
        <svg [w:16px] viewBox="0 0 256 256"> 
            <icon-error>
        <svg [bgc:blue fill:white] viewBox="0 0 256 256"> 
            <{icon-close}>
```

All icons are SVG-based and can be styled using Imba's CSS syntax.

## 👥 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.