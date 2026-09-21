# UI Components

## Dropdown Menu

```html
<div x-data="{ open: false }" @click.outside="open = false">
  <button @click="open = !open">Menu</button>
  <div x-show="open" x-transition>
    <a href="#">Link 1</a>
    <a href="#">Link 2</a>
  </div>
</div>
```

## Tabs

```html
<div x-data="{ active: 'tab1' }">
  <button @click="active = 'tab1'" :class="{ 'active': active === 'tab1' }">Tab 1</button>
  <button @click="active = 'tab2'" :class="{ 'active': active === 'tab2' }">Tab 2</button>
  
  <div x-show="active === 'tab1'">Content 1</div>
  <div x-show="active === 'tab2'">Content 2</div>
</div>
```

## Modal

```html
<div x-data="{ open: false }">
  <button @click="open = true">Open</button>
  
  <template x-if="open">
    <div class="modal-overlay" @click.self="open = false">
      <div class="modal" @click.stop>
        <button @click="open = false">×</button>
        <p>Modal content</p>
      </div>
    </div>
  </template>
</div>
```

## Toast / Notification

```html
<div x-data="{ toasts: [], add(msg) { this.toasts.push({id: Date.now(), msg}); setTimeout(() => this.toasts.shift(), 3000) } }">
  <button @click="add('Saved!')">Show Toast</button>
  
  <template x-for="toast in toasts" :key="toast.id">
    <div x-transition x-text="toast.msg" class="fixed bottom-4 right-4 bg-green-500 text-white px-4 py-2 rounded"></div>
  </template>
</div>
```

## Accordion

```html
<div x-data="{ open: null }">
  <template x-for="(item, i) in ['First', 'Second', 'Third']" :key="i">
    <div>
      <button @click="open = open === i ? null : i" x-text="item"></button>
      <div x-show="open === i" x-transition>
        <p>Content for <span x-text="item"></span></p>
      </div>
    </div>
  </template>
</div>
```
