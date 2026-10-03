---
name: alpinejs
description: AlpineJS best practices and patterns. Use when writing HTML with Alpine.js directives to avoid common mistakes like long inline JavaScript strings.
---

# Alpine.js Development

You are an expert in Alpine.js for building lightweight, reactive web interfaces. You like to pair this with Tailwind CSS and HTMX with the goal of simplicity.
Use only the Alpine.js documentation included in this skill. Do not supplement it with general ARIA or web-platform conventions unless I explicitly ask.

## Additional Documentation

Detailed examples and patterns are available in the `docs/` folder:

**Components:**
- `docs/accordion.md` - Collapsible content sections
- `docs/carousel.md` - Image/content sliders
- `docs/combobox.md` - Searchable select inputs
- `docs/components.md` - General UI component patterns
- `docs/dropdown.md` - Menu dropdowns
- `docs/modal.md` - Dialog overlays
- `docs/notifications.md` - Toast/notification patterns
- `docs/popover.md` - Floating content panels
- `docs/radiogroup.md` - Radio button groups
- `docs/select.md` - Custom select inputs
- `docs/tabs.md` - Tabbed interfaces
- `docs/toggle.md` - Switch/toggle controls
- `docs/tooltip.md` - Hover tooltips

**Patterns & Integrations:**
- `docs/patterns.md` - Data patterns (Form Validation, Fetch, Search, Infinite Scroll, Sortable, LocalStorage)
- `docs/integrations.md` - Framework integrations (Tailwind, Laravel/Livewire, Ghost, HTMX, Web Components)

# AlpineJS Best Practices

## Golden Rule: Keep Attributes Short

**Never** put complex logic in HTML attributes. If your `x-data`, `x-init`, or any directive exceeds ~50 characters, extract it.

## Directive Cheatsheet

| Directive | Purpose | Example |
|-----------|---------|---------|
| `x-data` | Declare reactive component state | `x-data="{ open: false }"` |
| `x-init` | Run code on component init | `x-init="fetchData()"` |
| `x-show` | Toggle visibility (CSS display) | `x-show="open"` |
| `x-if` | Conditional rendering (must wrap `<template>`) | `<template x-if="show">` |
| `x-for` | Loop (must wrap `<template>`) | `<template x-for="item in items">` |
| `x-bind:` / `:` | Bind attribute to expression | `:class="{ active: isActive }"` |
| `x-on:` / `@` | Listen to events | `@click="open = !open"` |
| `x-model` | Two-way bind form inputs | `x-model="email"` |
| `x-text` | Set text content | `x-text="message"` |
| `x-html` | Set inner HTML | `x-html="htmlContent"` |
| `x-ref` | Reference element via `$refs` | `x-ref="input"` |
| `x-cloak` | Hide until Alpine initializes | `x-cloak` (add CSS: `[x-cloak] { display: none; }`) |
| `x-transition` | Apply enter/leave transitions | `x-transition` or `x-transition.duration.300ms` |
| `x-effect` | Run reactive side effects | `x-effect="console.log(count)"` |


## Core Principles

- Write concise, technical responses with accurate Alpine.js examples
- Use Alpine.js for lightweight, declarative interactivity
- Prioritize performance optimization and minimal JavaScript
- Integrate seamlessly with Tailwind CSS and backend frameworks such as HTMX
- Prefer Alpine.js ONLY for user interactivity, the HTML is the dom/state. It is the backend that verifies the state

## Installation

### CDN (simplest)
```html
<script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
```

### NPM (Prefer)
```bash
npm install alpinejs
```

```js
import Alpine from 'alpinejs'
window.Alpine = Alpine
Alpine.start()
```

## Directives

### x-data
Defines a component's reactive state. Required on parent element for most directives.

```html
<div x-data="{ count: 0, name: 'Alpine' }">
  <span x-text="count"></span>
</div>
```

- Properties are available to all child elements
- Child data overrides parent data with same name
- Can use methods and getters:

```html
<div x-data="{
  open: false,
  get isOpen() { return this.open },
  toggle() { this.open = !this.open }
}">
```

### x-init
Runs code when element initializes.

```html
<div x-data x-init="console.log('initialized')">
<div x-data x-init="fetch('/api').then(r => r.json()).then(d => this.data = d)">
```

### x-show
Toggles element visibility (display: none).

```html
<div x-show="open">Visible when open is true</div>
<div x-show="open" x-transition>With transition</div>
```

### x-bind (or :)
Binds attribute values.

```html
<div :class="{ 'active': isActive }">
<a :href="url">
<img :src="imageUrl" :alt="imageName">
<div :style="{ 'color': color }">
```

### x-on (or @)
Listens for events.

```html
<button @click="count++">Click me</button>
<button x-on:click="count++">Click me</button>
<input @keyup.enter="submit">
<div @mouseover="hovering = true" @mouseleave="hovering = false">
<form @submit.prevent="save">
<div @click.outside="open = false">
```

**Modifiers:**
- `.prevent` - preventDefault()
- `.stop` - stopPropagation()
- `.self` - only trigger if event target is element itself
- `.once` - remove listener after first trigger
- `.outside` - trigger when clicking outside element

### x-text
Sets inner text content.

```html
<span x-text="message"></span>
<span x-text="count * 2"></span>
```

### x-html
Sets innerHTML (use cautiously with trusted content).

```html
<div x-html="richText"></div>
```

### x-model
Two-way binds input value to data.

```html
<input type="text" x-model="name">
<input type="checkbox" x-model="agree">
<select x-model="selected">
<textarea x-model="content"></textarea>
```

**Modifiers:**
- `.lazy` - sync on change instead of input
- `.number` - cast to number
- `.trim` - trim whitespace

### x-modelable
Makes a property bindable from parent.

```html
<!-- Child component -->
<div x-data="{ open: false }" x-modelable="open" x-model="$parent.modalOpen">

<!-- Parent -->
<div x-data="{ modalOpen: false }">
  <button @click="modalOpen = !modalOpen">Toggle</button>
</div>
```

### x-for
Loops through arrays. Must be on `<template>` element.

```html
<template x-for="item in items" :key="item.id">
  <div x-text="item.name"></div>
</template>

<template x-for="(item, index) in items" :key="item.id">
  <div x-text="`${index}: ${item.name}`"></div>
</template>
```

### x-if
Conditionally adds/removes element from DOM. Must be on `<template>`.

```html
<template x-if="show">
  <div>This element is added/removed from DOM</div>
</template>
```

### x-transition
Adds CSS transitions to x-show/x-if elements.

```html
<div x-show="open"
     x-transition:enter="transition ease-out duration-300"
     x-transition:enter-start="opacity-0 transform -translate-y-2"
     x-transition:enter-end="opacity-100 transform translate-y-0"
     x-transition:leave="transition ease-in duration-200"
     x-transition:leave-start="opacity-100"
     x-transition:leave-end="opacity-0">
```

Shorter syntax:
```html
<div x-show="open" x-transition.opacity.duration.500ms>
<div x-show="open" x-transition.scale.80>
<div x-show="open" x-transition.slide.bottom>
```

### x-effect
Runs reactive effect when dependencies change.

```html
<div x-data="{ count: 0 }" x-effect="console.log('count:', count)">
```

### x-ignore
Prevents Alpine from processing element and children.

```html
<div x-ignore>
  <!-- Alpine ignores this content -->
</div>
```

### x-ref
Access DOM elements directly.

```html
<div x-data x-ref="container">
  <button @click="$refs.container.style.background = 'red'">
```

### x-cloak
Hides element until Alpine initializes. Add CSS: `[x-cloak] { display: none !important; }`

```html
<div x-cloak x-show="open">Content flashes not visible</div>
```

### x-teleport
Moves element to another location in DOM.

```html
<div x-data>
  <button @click="open = true">Open Modal</button>
  <template x-if="open">
    <div x-teleport="body">
      <div class="modal">Modal content</div>
    </div>
  </template>
</div>
```

### x-id
Generates unique IDs for accessibility.

```html
<div x-data x-id="['text-label']">
  <label :for="$id('text-label')">Name</label>
  <input :id="$id('text-label')" type="text">
</div>
```

## Magic Properties

Available in x-data expressions:

| Magic | Description |
|-------|-------------|
| `$el` | Current element |
| `$refs` | Access x-ref elements |
| `$store` | Access global stores |
| `$watch` | Watch property changes |
| `$dispatch` | Dispatch custom events |
| `$nextTick` | Run after DOM update |
| `$root` | Root component element |
| `$data` | Current component data |
| `$id` | Access x-id values |

### Examples

```html
<div x-data="{ count: 0 }">
  <button @click="$el.textContent = 'Clicked!'">
  
  <div x-ref="info" x-init="$nextTick(() => $refs.info.focus())">
  
  <button @click="$store.cart.add(item)">
  
  <div x-effect="$watch('count', val => console.log(val))">
  
  <button @click="$dispatch('item-added', { id: 1 })">
</div>
```

## Global APIs

### Alpine.data()
Registers reusable component data.

```js
document.addEventListener('alpine:init', () => {
  Alpine.data('dropdown', () => ({
    open: false,
    toggle() { this.open = !this.open }
  }))
})
```

```html
<div x-data="dropdown">
  <button @click="toggle">Toggle</button>
  <div x-show="open">Content</div>
</div>
```

### Alpine.store()
Creates global reactive state.

```js
Alpine.store('cart', {
  items: [],
  get count() { return this.items.length },
  add(item) { this.items.push(item) }
})
```

```html
<div x-data>
  <span x-text="$store.cart.count"></span>
  <button @click="$store.cart.add(item)">Add</button>
</div>
```

### Alpine.bind()
Registers reusable attribute bindings.

```js
Alpine.bind('tooltip', (text) => ({
  'x-data': { show: false, text },
  '@mouseenter': 'show = true',
  '@mouseleave': 'show = false',
}))
```

```html
<div x-bind="tooltip('My tooltip')">
```

## Integration Patterns

### With Tailwind CSS
- Use Tailwind for styling, Alpine for behavior
- Combine `x-bind:class` with Tailwind utilities
- Use transitions with `x-transition` and Tailwind

```html
<div x-data="{ open: false }">
  <button @click="open = !open" 
          :class="open ? 'bg-blue-600' : 'bg-gray-200'">
    Toggle
  </button>
  <div x-show="open" x-transition.opacity>
    Content
  </div>
</div>
```


## Best Practices

### Performance
- Keep `x-data` objects small and focused
- Use `x-show` over `x-if` when possible for better performance (retains state)
- Lazy load heavy components
- Minimize DOM manipulation

### Code Organization
- Extract reusable logic into Alpine.data() components
- Use Alpine.store() for shared state
- Keep inline expressions simple; move complex logic to methods
- Use meaningful variable names

### Accessibility
- Ensure keyboard navigation works
- Use proper ARIA attributes
- Test with screen readers
- Maintain focus management
- Use `x-id` for unique IDs in forms


### Form Validation
```html
<form x-data="{ email: '', isValid: false }" @submit.prevent="submit">
  <input x-model="email" @input="isValid = validateEmail(email)">
  <button :disabled="!isValid">Submit</button>
</form>
```

### Fetch Data
```html
<div x-data="{ items: [], loading: true }" x-init="
  fetch('/api/items')
    .then(r => r.json())
    .then(d => items = d)
    .finally(() => loading = false)
">
  <template x-if="loading">
    <p>Loading...</p>
  </template>
  <template x-for="item in items" :key="item.id">
    <div x-text="item.name"></div>
  </template>
</div>
```

### List with Search
```html
<div x-data="{
  search: '',
  items: ['Apple', 'Banana', 'Cherry'],
  get filtered() {
    return this.items.filter(i => 
      i.toLowerCase().includes(this.search.toLowerCase())
    )
  }
}">
  <input x-model="search" placeholder="Search...">
  <template x-for="item in filtered" :key="item">
    <div x-text="item"></div>
  </template>
</div>
```


## Tips

- Use `x-cloak` with `[x-cloak] { display: none !important; }` to prevent FOUC
- `x-for` must be on `<template>`, not directly on element
- `x-if` must be on `<template>`, not directly on element
- Use `$nextTick` when you need to access DOM after state changes
- `@click.outside` is a convenient way to close dropdowns/modals
- Use `Alpine.store()` for state shared across multiple components
- Use `Alpine.data()` for reusable component logic
- Prefer `x-show` over `x-if` for toggle elements (retains state)
- Use `x-transition` for smooth show/hide animations
