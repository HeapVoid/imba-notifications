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
imba.mount <notification-center state=notify>

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

The `<notification-center>` tag is responsible for rendering notifications from a given Notifications class instance.

```imba
imba.mount <notification-center state=notifications>
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
tag custom-notifications < notification-center
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
    notification-center@not(#_)
        w:350px
        > .notification
            > .wrapper
                > .header
                    > .icon
                        @.success
                        @.info
                        @.caution
                        @.error
                    > .title
                    > .close
                > .content
                    > .wrapper
                        > .text
                        > .details
                        > .footer
            > .timer
```

### 📋 Available CSS Classes

The notification component uses the following CSS classes that you can customize:

```imba
    .notification
        pos:rel
        d:grid tween:grid-template-rows var(--wipe) ease
        pe:auto cursor:default
        mt:10px mr:10px rd:5px
        backdrop-filter: blur(20px)
        bgc:light-dark(black/8, white/10)
        bd:1px solid light-dark(black/16, white/20)
    .header 
        d:hcc m:10px
    .icon 
        w:24px
        @.success fill:light-dark(#1b9023,#61e16a)
        @.info fill:light-dark(#0b46b3,#49bfff)
        @.caution fill:light-dark(#cf9400,#faff5b)
        @.error fill:light-dark(#ac0000,#ff3b1d)
    .title 
        ml:10px 
        fs:15px fw:normal 
        c:light-dark(black, white)
    .close 
        ml:auto w:26px h:26px p:5px rd:4px 
        cursor:pointer 
        fill:light-dark(black, white) 
        bgc@hover:light-dark(black/20, white/20)
    .content
        d:grid tween:grid-template-rows var(--expand) ease
        ml:44px mr:36px
    .text 
        fs:12px fw:normal 
        c:light-dark(black/80, white/60)
    .details 
        w:100% mt:15px p:10px rd:4px
        bgc:light-dark(black/5, white/10) 
        fs:11px fw:normal
        c:light-dark(black, white/90)
        overflow-wrap:break-word word-wrap:break-word ws:normal
    .footer
        mb:15px
    .timer 
        pos:rel 
        px:10px py:2px w:100% ta:center
        fs:11px fw:normal ws:nowrap of:hidden tof:ellipsis
        c:light-dark(black/70, white/70)
        bgc:light-dark(black/5, white/10)
        @before
            content: ''
            pos:abs h:100% t:0 l:0
            bgc:light-dark(black/5, white/10)
            animation: progress calc(var(--show) + var(--display)) linear forwards
            @keyframes progress
                from w:0%
                to w:100%

    .show
        gtr: 1fr
        animation: show var(--show) ease
        @keyframes show	
            from transform: translateX(100%)
    .hide
        gtr: 1fr
        animation: hide var(--hide) ease forwards
        @keyframes hide
            to transform: translateX(100%) mr:0px
    .wipe
        transform: translateX(100%) mr:0px
        gtr: 0fr 
        animation: wipe var(--wipe) ease forwards
        @keyframes wipe
            to my:0 py:0 bd:0px
```

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

The package exports 5 icons that you can use in your application without any additional dependencies or imports.

```imba
tag MyComponent
    <self>
        <icon-success> 
        <icon-info> 
        <icon-caution> 
        <icon-error> 
        <icon-close> 
```

All icons are SVG-based and can be styled using Imba's CSS syntax.

## 👥 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.