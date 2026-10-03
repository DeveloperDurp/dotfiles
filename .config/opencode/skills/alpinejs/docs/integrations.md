# Integration Patterns

## Tailwind CSS

- Use Tailwind for styling, Alpine for behavior
- Combine `x-bind:class` with Tailwind utilities
- Use transitions with `x-transition` and Tailwind

```html
<div x-data="{ open: false }">
  <button @click="open = !open" 
          :class="open ? 'bg-blue-600 text-white' : 'bg-gray-200 text-gray-800'"
          class="px-4 py-2 rounded transition-colors">
    Toggle
  </button>
  <div x-show="open" x-transition.opacity class="mt-2 p-4 bg-white shadow rounded">
    Content
  </div>
</div>
```

## Laravel / Livewire (TALL Stack)

- Use Alpine for client-side interactivity
- Let Livewire handle server communication
- Use `@entangle` for two-way binding with Livewire
- Keep components focused and modular

```html
<div x-data="{ search: '' }" wire:ignore>
  <input wire:model.debounce.300ms="search" x-model="localSearch" placeholder="Search...">
  
  <div x-show="localSearch.length > 0">
    <!-- Client-side filtering with Alpine -->
  </div>
</div>
```

### Entangle Example

```html
<div x-data="{ open: false }" wire:ignore>
  <button @click="open = true">Open</button>
  
  <!-- Two-way sync with Livewire property -->
  <div x-data="{ @entangle('modalOpen') }" x-show="modalOpen">
    <input wire:model="title" x-model="localTitle">
  </div>
</div>
```

## Ghost CMS

- Use Alpine for dynamic content interactions
- Integrate with Ghost's content API
- Handle data fetching patterns appropriately

```html
<div x-data="{ posts: [], loading: true }" x-init="
  fetch('https://your-ghost-site.com/ghost/api/content/posts/?key=YOUR_KEY')
    .then(r => r.json())
    .then(d => posts = d.posts)
    .finally(() => loading = false)
">
  <template x-for="post in posts" :key="post.id">
    <article>
      <h2 x-text="post.title"></h2>
      <div x-html="post.excerpt"></div>
    </article>
  </template>
</div>
```

## Alpine + HTMX

```html
<!-- HTMX handles server requests, Alpine manages local state -->
<div x-data="{ count: 0 }" hx-post="/increment" hx-swap="none" @htmx:after-request="count++">
  <button>Count: <span x-text="count"></span></button>
</div>
```

## Alpine + Web Components

```html
<my-component x-data="{ value: '' }">
  <input x-model="value" slot="input">
  <span x-text="value" slot="output"></span>
</my-component>

<script>
  class MyComponent extends HTMLElement {
    connectedCallback() {
      this.attachShadow({ mode: 'open' });
      this.shadowRoot.innerHTML = `
        <slot name="input"></slot>
        <slot name="output"></slot>
      `;
    }
  }
  customElements.define('my-component', MyComponent);
</script>
```
