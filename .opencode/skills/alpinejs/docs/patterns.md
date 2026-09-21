# Data Patterns

## Form Validation

```html
<form x-data="{ email: '', password: '', errors: {} }" @submit.prevent="
  errors = {};
  if (!email) errors.email = 'Required';
  if (password.length < 8) errors.password = 'Min 8 characters';
  if (Object.keys(errors).length === 0) submit();
">
  <input type="email" x-model="email" :class="errors.email ? 'border-red-500' : ''">
  <span x-show="errors.email" x-text="errors.email" class="text-red-500"></span>
  
  <input type="password" x-model="password" :class="errors.password ? 'border-red-500' : ''">
  <span x-show="errors.password" x-text="errors.password" class="text-red-500"></span>
  
  <button type="submit">Submit</button>
</form>
```

## Fetch Data

```html
<div x-data="{ items: [], loading: true, error: null }" x-init="
  fetch('/api/items')
    .then(r => r.json())
    .then(d => items = d)
    .catch(e => error = e.message)
    .finally(() => loading = false)
">
  <template x-if="loading">
    <p>Loading...</p>
  </template>
  <template x-if="error">
    <p x-text="error" class="text-red-500"></p>
  </template>
  <template x-for="item in items" :key="item.id">
    <div x-text="item.name"></div>
  </template>
</div>
```

## List with Search & Filter

```html
<div x-data="{
  search: '',
  activeFilter: 'all',
  items: [
    { name: 'Apple', type: 'fruit' },
    { name: 'Carrot', type: 'vegetable' },
    { name: 'Banana', type: 'fruit' }
  ],
  get filtered() {
    return this.items.filter(i => {
      const matchesSearch = i.name.toLowerCase().includes(this.search.toLowerCase());
      const matchesFilter = this.activeFilter === 'all' || i.type === this.activeFilter;
      return matchesSearch && matchesFilter;
    })
  }
}">
  <input x-model="search" placeholder="Search...">
  
  <div class="flex gap-2">
    <button @click="activeFilter = 'all'" :class="activeFilter === 'all' ? 'bg-blue-500 text-white' : ''">All</button>
    <button @click="activeFilter = 'fruit'" :class="activeFilter === 'fruit' ? 'bg-blue-500 text-white' : ''">Fruit</button>
    <button @click="activeFilter = 'vegetable'" :class="activeFilter === 'vegetable' ? 'bg-blue-500 text-white' : ''">Vegetable</button>
  </div>
  
  <template x-for="item in filtered" :key="item.name">
    <div x-text="item.name"></div>
  </template>
</div>
```

## Infinite Scroll

```html
<div x-data="{
  items: [],
  page: 1,
  loading: false,
  hasMore: true,
  async loadMore() {
    if (this.loading || !this.hasMore) return;
    this.loading = true;
    const res = await fetch(`/api/items?page=${this.page}`);
    const data = await res.json();
    this.items = [...this.items, ...data.items];
    this.hasMore = data.hasMore;
    this.page++;
    this.loading = false;
  }
}" x-init="loadMore()" @scroll.window="if (window.innerHeight + window.scrollY >= document.body.offsetHeight - 200) loadMore()">
  
  <template x-for="item in items" :key="item.id">
    <div x-text="item.name"></div>
  </template>
  
  <div x-show="loading" x-text="'Loading...'"></div>
</div>
```

## Sortable List

```html
<div x-data="{
  items: ['Banana', 'Apple', 'Cherry'],
  dragIndex: null,
  start(i) { this.dragIndex = i },
  end(i) { 
    const item = this.items.splice(this.dragIndex, 1)[0];
    this.items.splice(i, 0, item);
    this.dragIndex = null;
  }
}">
  <template x-for="(item, i) in items" :key="item">
    <div draggable="true" 
         @dragstart="start(i)" 
         @dragover.prevent 
         @drop="end(i)"
         class="cursor-move p-2 border"
         x-text="item">
    </div>
  </template>
</div>
```

## Local Storage Persistence

```html
<div x-data="{
  theme: localStorage.getItem('theme') || 'light',
  toggle() {
    this.theme = this.theme === 'light' ? 'dark' : 'light';
    localStorage.setItem('theme', this.theme);
    document.documentElement.classList.toggle('dark', this.theme === 'dark');
  }
}" x-init="document.documentElement.classList.toggle('dark', theme === 'dark')">
  <button @click="toggle()" x-text="theme === 'light' ? '🌙' : '☀️'"></button>
</div>
```
