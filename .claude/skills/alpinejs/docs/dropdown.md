<div class="flex justify-center">
    <div
        x-data="{
            open: false,
            toggle() {
                if (this.open) {
                    return this.close()
                }

                this.$refs.button.focus()

                this.open = true
            },
            close(focusAfter) {
                if (! this.open) return

                this.open = false

                focusAfter && focusAfter.focus()
            }
        }"
        x-on:keydown.escape.prevent.stop="close($refs.button)"
        x-on:focusin.window="! $refs.panel.contains($event.target) && close()"
        x-id="['dropdown-button']"
        class="relative"
    >
        <!-- Button -->
        <button
            x-ref="button"
            x-on:click="toggle()"
            :aria-expanded="open"
            :aria-controls="$id('dropdown-button')"
            type="button"
            class="relative flex items-center whitespace-nowrap justify-center gap-2 py-2 rounded-lg shadow-sm bg-white hover:bg-gray-50 text-gray-800 border border-gray-200 hover:border-gray-200 px-4"
        >
            <span>Options</span>

            <!-- Heroicon: micro chevron-down -->
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-4">
                <path fill-rule="evenodd" d="M4.22 6.22a.75.75 0 0 1 1.06 0L8 8.94l2.72-2.72a.75.75 0 1 1 1.06 1.06l-3.25 3.25a.75.75 0 0 1-1.06 0L4.22 7.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
            </svg>
        </button>

        <!-- Panel -->
        <div
            x-ref="panel"
            x-show="open"
            x-transition.origin.top.left
            x-on:click.outside="close($refs.button)"
            :id="$id('dropdown-button')"
            x-cloak
            class="absolute left-0 min-w-48 rounded-lg shadow-sm mt-2 z-10 origin-top-left bg-white p-1.5 outline-none border border-gray-200"
        >
            <a href="#new" class="px-2 lg:py-1.5 py-2 w-full flex items-center rounded-md transition-colors text-left text-gray-800 hover:bg-gray-50 focus-visible:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed">
                New Task
            </a>

            <a href="#edit" class="px-2 lg:py-1.5 py-2 w-full flex items-center rounded-md transition-colors text-left text-gray-800 hover:bg-gray-50 focus-visible:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed">
                Edit Task
            </a>

            <a href="#delete" class="px-2 lg:py-1.5 py-2 w-full flex items-center rounded-md transition-colors text-left text-gray-800 hover:bg-red-50 hover:text-red-600 focus-visible:bg-red-50 focus-visible:text-red-600 disabled:opacity-50 disabled:cursor-not-allowed">
                Delete Task
            </a>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Menu -->
<div x-data x-menu class="relative">

    <!-- Menu Button -->
    <button x-menu:button class="relative flex items-center whitespace-nowrap justify-center gap-2 py-2 rounded-lg shadow-sm bg-white hover:bg-gray-50 text-gray-800 border border-gray-200 hover:border-gray-200 px-4">
        <span>Options</span>

        <!-- Heroicon: micro chevron-down -->
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-4">
            <path fill-rule="evenodd" d="M4.22 6.22a.75.75 0 0 1 1.06 0L8 8.94l2.72-2.72a.75.75 0 1 1 1.06 1.06l-3.25 3.25a.75.75 0 0 1-1.06 0L4.22 7.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
        </svg>
    </button>

    <!-- Menu Items -->
    <div
        x-menu:items
        x-transition.origin.top.left
        class="absolute left-0 min-w-48 rounded-lg shadow-sm mt-2 z-10 origin-top-left bg-white divide-y divide-gray-200 outline-none border border-gray-200"
        x-cloak
    >
        <div class="p-1.5" role="group">
            <!-- Menu Item -->
            <button
                x-menu:item
                type="button"
                :class="{
                    'bg-gray-50': $menuItem.isActive,
                    'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
                }"
                class="px-2.5 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
            >
                New post
            </button>
        </div>

        <div class="p-1.5" role="group">
            <button
                x-menu:item
                type="button"
                :class="{
                    'bg-gray-50': $menuItem.isActive,
                    'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
                }"
                class="px-2.5 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
            >
                Copy
            </button>

            <button
                x-menu:item
                type="button"
                :class="{
                    'bg-gray-50': $menuItem.isActive,
                    'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
                }"
                class="px-2.5 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
                disabled
            >
                Share
            </button>
        </div>

        <div class="p-1.5" role="group">
            <button
                x-menu:item
                type="button"
                :class="{
                    'bg-red-50 text-red-600': $menuItem.isActive,
                    'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
                }"
                class="px-2.5 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
            >
                Delete
            </button>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Menu -->
<div x-data x-menu class="relative">

    <!-- Menu Button -->
    <button x-menu:button class="relative flex items-center whitespace-nowrap justify-center gap-2 py-2 rounded-lg shadow-sm bg-white hover:bg-gray-50 text-gray-800 border border-gray-200 hover:border-gray-200 px-4">
        <span>Options</span>

        <!-- Heroicon: micro chevron-down -->
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-4">
            <path fill-rule="evenodd" d="M4.22 6.22a.75.75 0 0 1 1.06 0L8 8.94l2.72-2.72a.75.75 0 1 1 1.06 1.06l-3.25 3.25a.75.75 0 0 1-1.06 0L4.22 7.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
        </svg>
    </button>

    <!-- Menu Items -->
    <div
        x-menu:items
        x-transition.origin.top.left
        class="absolute left-0 min-w-48 rounded-lg shadow-sm mt-2 z-10 origin-top-left bg-white divide-y divide-gray-200 outline-none border border-gray-200"
        x-cloak
    >
        <div class="p-1.5" role="group">
            <!-- Menu Item -->
            <button
                x-menu:item
                type="button"
                :class="{
                    'bg-gray-50': $menuItem.isActive,
                    'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
                }"
                class="px-2 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
            >
                <svg class="shrink-0 size-5 mr-2" :class="{ 'text-gray-400': ! $menuItem.isActive  }" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                    <path d="M10.75 4.75a.75.75 0 0 0-1.5 0v4.5h-4.5a.75.75 0 0 0 0 1.5h4.5v4.5a.75.75 0 0 0 1.5 0v-4.5h4.5a.75.75 0 0 0 0-1.5h-4.5v-4.5Z"></path>
                </svg>
                New post
            </button>
        </div>
        <div class="p-1.5" role="group">
            <button
                x-menu:item
                type="button"
                :class="{
                    'bg-gray-50': $menuItem.isActive,
                    'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
                }"
                class="px-2 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
            >
                <svg class="shrink-0 size-5 mr-2" :class="{ 'text-gray-400': ! $menuItem.isActive  }" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M15.988 3.012A2.25 2.25 0 0 1 18 5.25v6.5A2.25 2.25 0 0 1 15.75 14H13.5v-3.379a3 3 0 0 0-.879-2.121l-3.12-3.121a3 3 0 0 0-1.402-.791 2.252 2.252 0 0 1 1.913-1.576A2.25 2.25 0 0 1 12.25 1h1.5a2.25 2.25 0 0 1 2.238 2.012ZM11.5 3.25a.75.75 0 0 1 .75-.75h1.5a.75.75 0 0 1 .75.75v.25h-3v-.25Z" clip-rule="evenodd" />
                    <path d="M3.5 6A1.5 1.5 0 0 0 2 7.5v9A1.5 1.5 0 0 0 3.5 18h7a1.5 1.5 0 0 0 1.5-1.5v-5.879a1.5 1.5 0 0 0-.44-1.06L8.44 6.439A1.5 1.5 0 0 0 7.378 6H3.5Z" />
                </svg>
                Copy
            </button>

            <button
                x-menu:item
                type="button"
                :class="{
                    'bg-gray-50': $menuItem.isActive,
                    'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
                }"
                class="px-2 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
            >
                <span class="w-7"></span>
                Move
            </button>

            <button
                x-menu:item
                type="button"
                :class="{
                    'bg-gray-50': $menuItem.isActive,
                    'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
                }"
                class="px-2 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
                disabled
            >
                <svg class="shrink-0 size-5 mr-2" :class="{ 'text-gray-400': ! $menuItem.isActive }" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                    <path d="M13 4.5a2.5 2.5 0 1 1 .702 1.737L6.97 9.604a2.518 2.518 0 0 1 0 .792l6.733 3.367a2.5 2.5 0 1 1-.671 1.341l-6.733-3.367a2.5 2.5 0 1 1 0-3.475l6.733-3.366A2.52 2.52 0 0 1 13 4.5Z" />
                </svg>
                Share
            </button>
        </div>
        <div class="p-1.5" role="group">
            <button
                x-menu:item
                type="button"
                :class="{
                    'bg-red-50 text-red-600': $menuItem.isActive,
                    'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
                }"
                class="px-2 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
            >
                <svg class="shrink-0 size-5 mr-2" :class="{ 'text-gray-400': ! $menuItem.isActive }" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M8.75 1A2.75 2.75 0 0 0 6 3.75v.443c-.795.077-1.584.176-2.365.298a.75.75 0 1 0 .23 1.482l.149-.022.841 10.518A2.75 2.75 0 0 0 7.596 19h4.807a2.75 2.75 0 0 0 2.742-2.53l.841-10.52.149.023a.75.75 0 0 0 .23-1.482A41.03 41.03 0 0 0 14 4.193V3.75A2.75 2.75 0 0 0 11.25 1h-2.5ZM10 4c.84 0 1.673.025 2.5.075V3.75c0-.69-.56-1.25-1.25-1.25h-2.5c-.69 0-1.25.56-1.25 1.25v.325C8.327 4.025 9.16 4 10 4ZM8.58 7.72a.75.75 0 0 0-1.5.06l.3 7.5a.75.75 0 1 0 1.5-.06l-.3-7.5Zm4.34.06a.75.75 0 1 0-1.5-.06l-.3 7.5a.75.75 0 1 0 1.5.06l.3-7.5Z" clip-rule="evenodd" />
                </svg>
                Delete
            </button>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Menu -->
<div x-data x-menu class="relative">

    <!-- Menu Button -->
    <button x-menu:button class="relative flex items-center whitespace-nowrap justify-center gap-2 py-2.5 px-2.5 rounded-lg text-gray-800 hover:bg-gray-800/10">
        <span class="sr-only">Options</span>

        <!-- Heroicon: chevron-down -->
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="size-5">
          <path d="M3 10a1.5 1.5 0 1 1 3 0 1.5 1.5 0 0 1-3 0ZM8.5 10a1.5 1.5 0 1 1 3 0 1.5 1.5 0 0 1-3 0ZM15.5 8.5a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3Z" />
        </svg>
    </button>

    <!-- Menu Items -->
    <div
        x-menu:items
        x-transition.origin.top.left
        class="absolute left-0 min-w-48 rounded-lg shadow-sm mt-2 z-10 origin-top-left bg-white p-1.5 outline-none border border-gray-200"
        x-cloak
    >
        <!-- Menu Item -->
        <a
            x-menu:item
            href="#account"
            :class="{
                'bg-gray-50': $menuItem.isActive,
                'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
            }"
            class="px-2 lg:py-1.5 py-2 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
        >
            Account
        </a>
        <a
            x-menu:item
            href="#profile"
            :class="{
                'bg-gray-50': $menuItem.isActive,
                'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
            }"
            class="px-2 lg:py-1.5 py-2 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
        >
            Profile
        </a>
        <a
            x-menu:item
            href="#billing"
            :class="{
                'bg-gray-50': $menuItem.isActive,
                'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
            }"
            class="px-2 lg:py-1.5 py-2 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
            disabled
        >
            Billing
        </a>
        <a
            x-menu:item
            href="#logout"
            :class="{
                'bg-red-50 text-red-600': $menuItem.isActive,
                'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
            }"
            class="px-2 lg:py-1.5 py-2 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
        >
            Logout
        </a>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Menu -->
<div x-data x-menu class="relative">

    <!-- Menu Button -->
    <button x-menu:button class="relative flex items-center whitespace-nowrap justify-center gap-2 py-2 rounded-lg shadow-sm bg-white hover:bg-gray-50 text-gray-800 border border-gray-200 hover:border-gray-200 px-4">
        <span>Options</span>

        <!-- Heroicon: micro chevron-down -->
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-4">
            <path fill-rule="evenodd" d="M4.22 6.22a.75.75 0 0 1 1.06 0L8 8.94l2.72-2.72a.75.75 0 1 1 1.06 1.06l-3.25 3.25a.75.75 0 0 1-1.06 0L4.22 7.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
        </svg>
    </button>

    <!-- Menu Items -->
    <div
        x-menu:items
        x-transition.origin.top.left
        class="absolute left-0 min-w-48 rounded-lg shadow-sm mt-2 z-10 origin-top-left bg-white divide-y divide-gray-200 outline-none border border-gray-200"
        x-cloak
    >
        <div class="p-1.5" role="group">
            <div class="px-2.5 pt-2 pb-1 w-full flex items-center text-left text-xs font-medium text-gray-500">
                Account
            </div>

            <!-- Menu Item -->
            <button
                x-menu:item
                type="button"
                :class="{
                    'bg-gray-50': $menuItem.isActive,
                    'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
                }"
                class="px-2.5 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
            >
                New post
            </button>

            <a
                x-menu:item
                href="#permissions"
                :class="{
                    'bg-gray-50': $menuItem.isActive,
                    'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
                }"
                class="px-2.5 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
            >
                Permissions
            </a>
        </div>
        <div class="p-1.5" role="group">
            <div class="px-2.5 pt-2 pb-1 w-full flex items-center text-left text-xs font-medium text-gray-500">
                Billing
            </div>

            <a
                x-menu:item
                href="#transactions"
                :class="{
                    'bg-gray-50': $menuItem.isActive,
                    'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
                }"
                class="px-2.5 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
            >
                Transactions
            </a>

            <a
                x-menu:item
                href="#payouts"
                :class="{
                    'bg-gray-50': $menuItem.isActive,
                    'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
                }"
                class="px-2.5 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
            >
                Payouts
            </a>

            <a
                x-menu:item
                href="#refunds"
                :class="{
                    'bg-gray-50': $menuItem.isActive,
                    'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
                }"
                class="px-2.5 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
            >
                Refunds
            </a>
        </div>
        <div class="p-1.5" role="group">
            <a
                x-menu:item
                href="#logout"
                :class="{
                    'bg-red-50 text-red-600': $menuItem.isActive,
                    'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
                }"
                class="px-2.5 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
            >
                Logout
            </a>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Menu -->
<div x-data x-menu class="relative">

    <!-- Menu Button -->
    <button x-menu:button class="relative flex items-center whitespace-nowrap justify-center gap-2 py-2 rounded-lg shadow-sm bg-white hover:bg-gray-50 text-gray-800 border border-gray-200 hover:border-gray-200 px-4">
        <span>Options</span>

        <!-- Heroicon: micro chevron-down -->
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" class="size-4">
            <path fill-rule="evenodd" d="M4.22 6.22a.75.75 0 0 1 1.06 0L8 8.94l2.72-2.72a.75.75 0 1 1 1.06 1.06l-3.25 3.25a.75.75 0 0 1-1.06 0L4.22 7.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
        </svg>
    </button>

    <!-- Menu Items -->
    <div
        x-menu:items
        x-transition.origin.top.left
        class="absolute left-0 min-w-48 rounded-lg shadow-sm mt-2 z-10 origin-top-left bg-white p-1.5 outline-none border border-gray-200"
        x-cloak
    >
        <!-- Menu Item -->
        <button
            x-menu:item
            type="button"
            :class="{
                'bg-gray-50': $menuItem.isActive,
                'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
            }"
            class="px-2 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
        >
            <svg class="shrink-0 size-5 mr-2" :class="{ 'text-gray-400': ! $menuItem.isActive  }" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" class="size-5">
                <path d="m5.433 13.917 1.262-3.155A4 4 0 0 1 7.58 9.42l6.92-6.918a2.121 2.121 0 0 1 3 3l-6.92 6.918c-.383.383-.84.685-1.343.886l-3.154 1.262a.5.5 0 0 1-.65-.65Z" />
                <path d="M3.5 5.75c0-.69.56-1.25 1.25-1.25H10A.75.75 0 0 0 10 3H4.75A2.75 2.75 0 0 0 2 5.75v9.5A2.75 2.75 0 0 0 4.75 18h9.5A2.75 2.75 0 0 0 17 15.25V10a.75.75 0 0 0-1.5 0v5.25c0 .69-.56 1.25-1.25 1.25h-9.5c-.69 0-1.25-.56-1.25-1.25v-9.5Z" />
            </svg>

            Save

            <div class="ml-auto text-xs text-gray-400">⌘S</div>
        </button>

        <button
            x-menu:item
            type="button"
            :class="{
                'bg-gray-50': $menuItem.isActive,
                'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
            }"
            class="px-2 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
        >
            <svg class="shrink-0 size-5 mr-2" :class="{ 'text-gray-400': ! $menuItem.isActive  }" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path d="M7 3.5A1.5 1.5 0 0 1 8.5 2h3.879a1.5 1.5 0 0 1 1.06.44l3.122 3.12A1.5 1.5 0 0 1 17 6.622V12.5a1.5 1.5 0 0 1-1.5 1.5h-1v-3.379a3 3 0 0 0-.879-2.121L10.5 5.379A3 3 0 0 0 8.379 4.5H7v-1Z" />
                <path d="M4.5 6A1.5 1.5 0 0 0 3 7.5v9A1.5 1.5 0 0 0 4.5 18h7a1.5 1.5 0 0 0 1.5-1.5v-5.879a1.5 1.5 0 0 0-.44-1.06L9.44 6.439A1.5 1.5 0 0 0 8.378 6H4.5Z" />
            </svg>

            Duplicate

            <div class="ml-auto text-xs text-gray-400">⌘D</div>
        </button>

        <button
            x-menu:item
            type="button"
            :class="{
                'bg-red-50 text-red-600': $menuItem.isActive,
                'opacity-50 cursor-not-allowed': $menuItem.isDisabled,
            }"
            class="px-2 py-1.5 w-full flex items-center rounded-md transition-colors focus:outline-none text-left text-gray-800"
        >
            <svg class="shrink-0 size-5 mr-2" :class="{ 'text-gray-400': ! $menuItem.isActive }" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M8.75 1A2.75 2.75 0 0 0 6 3.75v.443c-.795.077-1.584.176-2.365.298a.75.75 0 1 0 .23 1.482l.149-.022.841 10.518A2.75 2.75 0 0 0 7.596 19h4.807a2.75 2.75 0 0 0 2.742-2.53l.841-10.52.149.023a.75.75 0 0 0 .23-1.482A41.03 41.03 0 0 0 14 4.193V3.75A2.75 2.75 0 0 0 11.25 1h-2.5ZM10 4c.84 0 1.673.025 2.5.075V3.75c0-.69-.56-1.25-1.25-1.25h-2.5c-.69 0-1.25.56-1.25 1.25v.325C8.327 4.025 9.16 4 10 4ZM8.58 7.72a.75.75 0 0 0-1.5.06l.3 7.5a.75.75 0 1 0 1.5-.06l-.3-7.5Zm4.34.06a.75.75 0 1 0-1.5-.06l-.3 7.5a.75.75 0 1 0 1.5.06l.3-7.5Z" clip-rule="evenodd" />
            </svg>

            Delete

            <div class="ml-auto text-xs text-gray-400">⌘⌫</div>
        </button>
    </div>
</div>