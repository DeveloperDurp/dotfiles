<!-- Tabs -->
<div
    x-data="{
        selectedId: null,
        init() {
            // Set the first available tab on the page on page load.
            this.$nextTick(() => this.select(this.$id('tab', 1)))
        },
        select(id) {
            this.selectedId = id
        },
        isSelected(id) {
            return this.selectedId === id
        },
        whichChild(el, parent) {
            return Array.from(parent.children).indexOf(el) + 1
        }
    }"
    x-id="['tab']"
    class="mx-auto max-w-3xl"
>
    <!-- Tab List -->
    <ul
        x-ref="tablist"
        @keydown.right.prevent.stop="$focus.wrap().next()"
        @keydown.home.prevent.stop="$focus.first()"
        @keydown.page-up.prevent.stop="$focus.first()"
        @keydown.left.prevent.stop="$focus.wrap().prev()"
        @keydown.end.prevent.stop="$focus.last()"
        @keydown.page-down.prevent.stop="$focus.last()"
        role="tablist"
        class="-mb-px flex items-stretch overflow-x-auto"
    >
        <!-- Tab -->
        <li>
            <button
                :id="$id('tab', whichChild($el.parentElement, $refs.tablist))"
                @click="select($el.id)"
                @mousedown.prevent
                @focus="select($el.id)"
                type="button"
                :tabindex="isSelected($el.id) ? 0 : -1"
                :aria-selected="isSelected($el.id)"
                :class="isSelected($el.id) ? 'border-gray-200 bg-white' : 'border-transparent'"
                class="inline-flex rounded-t-lg border-t border-l border-r px-5 py-2.5"
                role="tab"
            >Tab 1</button>
        </li>

        <li>
            <button
                :id="$id('tab', whichChild($el.parentElement, $refs.tablist))"
                @click="select($el.id)"
                @mousedown.prevent
                @focus="select($el.id)"
                type="button"
                :tabindex="isSelected($el.id) ? 0 : -1"
                :aria-selected="isSelected($el.id)"
                :class="isSelected($el.id) ? 'border-gray-200 bg-white' : 'border-transparent'"
                class="inline-flex rounded-t-lg border-t border-l border-r px-5 py-2.5"
                role="tab"
            >Tab 2</button>
        </li>
    </ul>

    <!-- Panels -->
    <div role="tabpanels" class="rounded-b-lg rounded-tr-lg border border-gray-200 bg-white">
        <!-- Panel -->
        <section
            x-show="isSelected($id('tab', whichChild($el, $el.parentElement)))"
            :aria-labelledby="$id('tab', whichChild($el, $el.parentElement))"
            role="tabpanel"
            class="p-8"
        >
            <h2 class="text-xl font-bold">Tab 1 Content</h2>
            <p class="mt-2 text-gray-500">Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio, quo sequi error quibusdam quas temporibus animi sapiente eligendi! Deleniti minima velit recusandae iure.</p>
            <button class="mt-5 rounded-lg border border-gray-200 px-4 py-2 text-sm text-gray-800">Something focusable</button>
        </section>

        <section
            x-show="isSelected($id('tab', whichChild($el, $el.parentElement)))"
            :aria-labelledby="$id('tab', whichChild($el, $el.parentElement))"
            role="tabpanel"
            class="p-8"
        >
            <h2 class="text-xl font-bold">Tab 2 Content</h2>
            <p class="mt-2 text-gray-500">Fugiat odit alias, eaque optio quas nobis minima reiciendis voluptate dolorem nisi facere debitis ea laboriosam vitae omnis ut voluptatum eos. Fugiat?</p>
            <button class="mt-5 rounded-lg border border-gray-200 px-4 py-2 text-sm text-gray-800">Something else focusable</button>
        </section>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<div x-data x-tabs class="mx-auto max-w-3xl">
    <div x-tabs:list class="-mb-px flex items-stretch overflow-x-auto">
        <button x-tabs:tab type="button"
            :class="$tab.isSelected ? 'border-gray-200 bg-white' : 'border-transparent'"
            class="inline-flex rounded-t-lg border-t border-l border-r px-5 py-2.5"
        >Tab 1</button>

        <button x-tabs:tab type="button"
            :class="$tab.isSelected ? 'border-gray-200 bg-white' : 'border-transparent'"
            class="inline-flex rounded-t-lg border-t border-l border-r px-5 py-2.5"
        >Tab 2</button>
    </div>

    <div x-tabs:panels class="rounded-b-lg rounded-tr-lg border border-gray-200 bg-white">
        <section x-tabs:panel class="p-8">
            <h2 class="text-xl font-bold">Tab 1 Content</h2>
            <p class="mt-2 text-gray-500">Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio, quo sequi error quibusdam quas temporibus animi sapiente eligendi! Deleniti minima velit recusandae iure.</p>
            <button class="mt-5 rounded-md border border-gray-200 px-4 py-2 text-sm">Take Action</button>
        </section>

        <section x-tabs:panel class="p-8">
            <h2 class="text-xl font-bold">Tab 2 Content</h2>
            <p class="mt-2 text-gray-500">Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
            <button class="mt-5 rounded-md border border-gray-200 px-4 py-2 text-sm">Take Action</button>
        </section>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Tabs -->
<div x-data x-tabs class="mx-auto max-w-3xl w-full">
    <!-- Tab Headings -->
    <div x-tabs:list class="flex gap-4 items-stretch border-b border-gray-800/10 overflow-x-auto">
        <!-- Tab -->
        <button x-tabs:tab type="button"
            :class="$tab.isSelected ? 'border-gray-800 text-gray-800' : 'border-transparent'"
            class="flex whitespace-nowrap gap-2 items-center px-5 py-2.5 border-b-2 font-medium text-gray-500 hover:text-gray-800"
        >Profile</button>

        <button x-tabs:tab type="button"
            :class="$tab.isSelected ? 'border-gray-800 text-gray-800' : 'border-transparent'"
            class="flex whitespace-nowrap gap-2 items-center px-5 py-2.5 border-b-2 font-medium text-gray-500 hover:text-gray-800"
        >Account</button>

        <button x-tabs:tab type="button"
            :class="$tab.isSelected ? 'border-gray-800 text-gray-800' : 'border-transparent'"
            class="flex whitespace-nowrap gap-2 items-center px-5 py-2.5 border-b-2 font-medium text-gray-500 hover:text-gray-800"
        >Billing</button>
    </div>

    <!-- Tab Panels -->
    <div x-tabs:panels class="w-full">
        <!-- Tab Panel -->
        <section x-tabs:panel class="py-8">
            <h2 class="text-base font-medium">Profile</h2>
            <p class="mt-2 text-gray-600 max-w-xl">Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio, quo sequi error quibusdam quas temporibus animi sapiente eligendi! Deleniti minima velit recusandae iure.</p>
        </section>

        <section x-tabs:panel class="py-8">
            <h2 class="text-base font-medium">Account</h2>
            <p class="mt-2 text-gray-600 max-w-xl">Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        </section>

        <section x-tabs:panel class="py-8">
            <h2 class="text-base font-medium">Billing</h2>
            <p class="mt-2 text-gray-600 max-w-xl">Ex culpa esse occaecat aliquip laboris. Culpa aliquip excepteur irure. Tempor ut nisi nulla quis non est magna id ipsum ea sunt commodo aliquip id. Incididunt ipsum nulla ex amet laborum cupidatat mollit et labore dolor.</p>
        </section>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Tabs -->
<div x-data x-tabs class="mx-auto max-w-3xl w-full">
    <!-- Tab Headings -->
    <div x-tabs:list class="flex items-stretch gap-4 border-b border-gray-800/10 overflow-x-auto">
        <!-- Tab -->
        <button x-tabs:tab type="button"
            :class="$tab.isSelected ? 'border-gray-800 text-gray-800' : 'border-transparent'"
            class="flex items-center gap-2 whitespace-nowrap border-b-2 px-5 py-2.5 text-gray-500 font-medium hover:text-gray-800"
        >
            <svg class="size-5 shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z"></path>
            </svg>
            Profile
        </button>
        <button x-tabs:tab type="button"
            :class="$tab.isSelected ? 'border-gray-800 text-gray-800' : 'border-transparent'"
            class="flex items-center gap-2 whitespace-nowrap border-b-2 px-5 py-2.5 text-gray-500 font-medium hover:text-gray-800"
        >
            <svg class="size-5 shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.325.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 0 1 1.37.49l1.296 2.247a1.125 1.125 0 0 1-.26 1.431l-1.003.827c-.293.241-.438.613-.43.992a7.723 7.723 0 0 1 0 .255c-.008.378.137.75.43.991l1.004.827c.424.35.534.955.26 1.43l-1.298 2.247a1.125 1.125 0 0 1-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.47 6.47 0 0 1-.22.128c-.331.183-.581.495-.644.869l-.213 1.281c-.09.543-.56.94-1.11.94h-2.594c-.55 0-1.019-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 0 1-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 0 1-1.369-.49l-1.297-2.247a1.125 1.125 0 0 1 .26-1.431l1.004-.827c.292-.24.437-.613.43-.991a6.932 6.932 0 0 1 0-.255c.007-.38-.138-.751-.43-.992l-1.004-.827a1.125 1.125 0 0 1-.26-1.43l1.297-2.247a1.125 1.125 0 0 1 1.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.086.22-.128.332-.183.582-.495.644-.869l.214-1.28Z"></path>
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"></path>
            </svg>
            Account
        </button>
        <button x-tabs:tab type="button"
            :class="$tab.isSelected ? 'border-gray-800 text-gray-800' : 'border-transparent'"
            class="flex items-center gap-2 whitespace-nowrap border-b-2 px-5 py-2.5 text-gray-500 font-medium hover:text-gray-800"
        >
            <svg class="size-5 shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18.75a60.07 60.07 0 0 1 15.797 2.101c.727.198 1.453-.342 1.453-1.096V18.75M3.75 4.5v.75A.75.75 0 0 1 3 6h-.75m0 0v-.375c0-.621.504-1.125 1.125-1.125H20.25M2.25 6v9m18-10.5v.75c0 .414.336.75.75.75h.75m-1.5-1.5h.375c.621 0 1.125.504 1.125 1.125v9.75c0 .621-.504 1.125-1.125 1.125h-.375m1.5-1.5H21a.75.75 0 0 0-.75.75v.75m0 0H3.75m0 0h-.375a1.125 1.125 0 0 1-1.125-1.125V15m1.5 1.5v-.75A.75.75 0 0 0 3 15h-.75M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm3 0h.008v.008H18V10.5Zm-12 0h.008v.008H6V10.5Z"></path>
            </svg>
            Billing
        </button>
    </div>

    <!-- Tab Panels -->
    <div x-tabs:panels class="w-full">
        <!-- Tab Panel -->
        <section x-tabs:panel class="py-8">
            <h2 class="text-base font-medium">Profile</h2>
            <p class="mt-2 text-gray-600 max-w-xl">Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio, quo sequi error quibusdam quas temporibus animi sapiente eligendi! Deleniti minima velit recusandae iure.</p>
        </section>

        <section x-tabs:panel class="py-8">
            <h2 class="text-base font-medium">Account</h2>
            <p class="mt-2 text-gray-600 max-w-xl">Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        </section>

        <section x-tabs:panel class="py-8">
            <h2 class="text-base font-medium">Billing</h2>
            <p class="mt-2 text-gray-600 max-w-xl">Ex culpa esse occaecat aliquip laboris. Culpa aliquip excepteur irure. Tempor ut nisi nulla quis non est magna id ipsum ea sunt commodo aliquip id. Incididunt ipsum nulla ex amet laborum cupidatat mollit et labore dolor.</p>
        </section>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Tabs -->
<div x-data x-tabs class="mx-auto max-w-sm w-full">
    <!-- Tab Headings -->
    <div class="overflow-x-auto">
        <div x-tabs:list class="inline-flex min-w-full h-10 rounded-lg bg-gray-800/5 p-1 lg:max-w-96">
            <!-- Tab -->
            <button x-tabs:tab type="button"
                :class="$tab.isSelected ? 'shadow-sm bg-white text-gray-800' : 'border-transparent'"
                class="flex whitespace-nowrap flex-1 justify-center items-center rounded-md font-medium text-gray-600 hover:text-gray-800 px-4"
            >Profile</button>

            <button x-tabs:tab type="button"
                :class="$tab.isSelected ? 'shadow-sm bg-white text-gray-800' : 'border-transparent'"
                class="flex whitespace-nowrap flex-1 justify-center items-center rounded-md font-medium text-gray-600 hover:text-gray-800 px-4"
            >Account</button>

            <button x-tabs:tab type="button"
                :class="$tab.isSelected ? 'shadow-sm bg-white text-gray-800' : 'border-transparent'"
                class="flex whitespace-nowrap flex-1 justify-center items-center rounded-md font-medium text-gray-600 hover:text-gray-800 px-4"
            >Billing</button>
        </div>
    </div>

    <!-- Tab Panels -->
    <div x-tabs:panels class="mt-8">
        <!-- Tab Panel -->
        <section x-tabs:panel>
            <h2 class="text-base text-gray-800 font-medium">Profile</h2>
            <p class="mt-2 text-gray-600">Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio, quo sequi error quibusdam quas temporibus animi sapiente eligendi!</p>
        </section>

        <section x-tabs:panel>
            <h2 class="text-base text-gray-800 font-medium">Account</h2>
            <p class="mt-2 text-gray-600">Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        </section>

        <section x-tabs:panel>
            <h2 class="text-base text-gray-800 font-medium">Billing</h2>
            <p class="mt-2 text-gray-600">Ex culpa esse occaecat aliquip laboris. Culpa aliquip excepteur irure. Tempor ut nisi nulla quis non est magna id ipsum ea sunt commodo aliquip id. Incididunt ipsum nulla ex amet laborum cupidatat mollit et labore dolor.</p>
        </section>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Tabs -->
<div x-data x-tabs class="mx-auto max-w-md w-full">
    <!-- Tab Headings -->
    <div class="overflow-x-auto">
        <div x-tabs:list class="inline-flex min-w-full h-10 rounded-lg bg-gray-800/5 p-1 lg:max-w-96">
            <!-- Tab -->
            <button x-tabs:tab type="button"
                :class="$tab.isSelected ? 'shadow-sm bg-white text-gray-800' : 'border-transparent'"
                class="flex flex-1 items-center justify-center gap-2 whitespace-nowrap rounded-md px-4 font-medium text-gray-600 hover:text-gray-800"
            >
                <svg class="size-5 shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z"></path>
                </svg>
                Profile
            </button>

            <button x-tabs:tab type="button"
                :class="$tab.isSelected ? 'shadow-sm bg-white text-gray-800' : 'border-transparent'"
                class="flex flex-1 items-center justify-center gap-2 whitespace-nowrap rounded-md px-4 font-medium text-gray-600 hover:text-gray-800"
            >
                <svg class="size-5 shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.325.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 0 1 1.37.49l1.296 2.247a1.125 1.125 0 0 1-.26 1.431l-1.003.827c-.293.241-.438.613-.43.992a7.723 7.723 0 0 1 0 .255c-.008.378.137.75.43.991l1.004.827c.424.35.534.955.26 1.43l-1.298 2.247a1.125 1.125 0 0 1-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.47 6.47 0 0 1-.22.128c-.331.183-.581.495-.644.869l-.213 1.281c-.09.543-.56.94-1.11.94h-2.594c-.55 0-1.019-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 0 1-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 0 1-1.369-.49l-1.297-2.247a1.125 1.125 0 0 1 .26-1.431l1.004-.827c.292-.24.437-.613.43-.991a6.932 6.932 0 0 1 0-.255c.007-.38-.138-.751-.43-.992l-1.004-.827a1.125 1.125 0 0 1-.26-1.43l1.297-2.247a1.125 1.125 0 0 1 1.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.086.22-.128.332-.183.582-.495.644-.869l.214-1.28Z"></path>
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"></path>
                </svg>
                Account
            </button>

            <button x-tabs:tab type="button"
                :class="$tab.isSelected ? 'shadow-sm bg-white text-gray-800' : 'border-transparent'"
                class="flex flex-1 items-center justify-center gap-2 whitespace-nowrap rounded-md px-4 font-medium text-gray-600 hover:text-gray-800"
            >
                <svg class="size-5 shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18.75a60.07 60.07 0 0 1 15.797 2.101c.727.198 1.453-.342 1.453-1.096V18.75M3.75 4.5v.75A.75.75 0 0 1 3 6h-.75m0 0v-.375c0-.621.504-1.125 1.125-1.125H20.25M2.25 6v9m18-10.5v.75c0 .414.336.75.75.75h.75m-1.5-1.5h.375c.621 0 1.125.504 1.125 1.125v9.75c0 .621-.504 1.125-1.125 1.125h-.375m1.5-1.5H21a.75.75 0 0 0-.75.75v.75m0 0H3.75m0 0h-.375a1.125 1.125 0 0 1-1.125-1.125V15m1.5 1.5v-.75A.75.75 0 0 0 3 15h-.75M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm3 0h.008v.008H18V10.5Zm-12 0h.008v.008H6V10.5Z"></path>
                </svg>
                Billing
            </button>
        </div>
    </div>

    <!-- Tab Panels -->
    <div x-tabs:panels class="mt-8">
        <!-- Tab Panel -->
        <section x-tabs:panel>
            <h2 class="text-base font-medium">Profile</h2>
            <p class="mt-2 text-gray-600">Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio, quo sequi error quibusdam quas temporibus animi sapiente eligendi!</p>
        </section>

        <section x-tabs:panel>
            <h2 class="text-base font-medium">Account</h2>
            <p class="mt-2 text-gray-600">Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        </section>

        <section x-tabs:panel>
            <h2 class="text-base font-medium">Billing</h2>
            <p class="mt-2 text-gray-600">Ex culpa esse occaecat aliquip laboris. Culpa aliquip excepteur irure. Tempor ut nisi nulla quis non est magna id ipsum ea sunt commodo aliquip id. Incididunt ipsum nulla ex amet laborum cupidatat mollit et labore dolor.</p>
        </section>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Tabs -->
<div x-data x-tabs class="mx-auto max-w-5xl flex flex-col items-start gap-6 sm:flex-row">
    <!-- Tab Headings -->
    <div x-tabs:list class="flex gap-2 sm:flex-col sm:w-1/4 sm:shrink-0">
        <!-- Tab -->
        <button x-tabs:tab type="button"
            :class="$tab.isSelected ? 'bg-gray-800/5 text-gray-800' : 'text-gray-700'"
            class="h-10 lg:h-8 relative flex items-center gap-3 rounded-lg  py-0 text-left w-full px-3 my-px border-gray-200 text-gray-500 hover:text-gray-800 hover:bg-gray-100"
        >
            Profile
        </button>

        <button x-tabs:tab type="button"
            :class="$tab.isSelected ? 'bg-gray-800/5 text-gray-800' : 'text-gray-700'"
            class="h-10 lg:h-8 relative flex items-center gap-3 rounded-lg  py-0 text-left w-full px-3 my-px border-gray-200 text-gray-500 hover:text-gray-800 hover:bg-gray-100"
        >
            Account
        </button>

        <button x-tabs:tab type="button"
            :class="$tab.isSelected ? 'bg-gray-800/5 text-gray-800' : 'text-gray-700'"
            class="h-10 lg:h-8 relative flex items-center gap-3 rounded-lg  py-0 text-left w-full px-3 my-px border-gray-200 text-gray-500 hover:text-gray-800 hover:bg-gray-100"
        >Billing</button>
    </div>

    <!-- Tab Panels -->
    <div x-tabs:panels class="rounded-lg border border-gray-200 bg-white">
        <!-- Tab Panel -->
        <section x-tabs:panel class="p-8">
            <h2 class="text-xl font-bold">Profile</h2>
            <p class="mt-2 text-gray-500">Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio, quo sequi error quibusdam quas temporibus animi sapiente eligendi! Deleniti minima velit recusandae iure.</p>
            <button class="mt-5 rounded-md border border-gray-200 px-4 py-2 text-sm">Take Action</button>
        </section>

        <section x-tabs:panel class="p-8">
            <h2 class="text-xl font-bold">Account</h2>
            <p class="mt-2 text-gray-500">Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
            <button class="mt-5 rounded-md border border-gray-200 px-4 py-2 text-sm">Take Action</button>
        </section>

        <section x-tabs:panel class="p-8">
            <h2 class="text-xl font-bold">Billing</h2>
            <p class="mt-2 text-gray-500">Ex culpa esse occaecat aliquip laboris. Culpa aliquip excepteur irure. Tempor ut nisi nulla quis non est magna id ipsum ea sunt commodo aliquip id. Incididunt ipsum nulla ex amet laborum cupidatat mollit et labore dolor.</p>
            <button class="mt-5 rounded-md border border-gray-200 px-4 py-2 text-sm">Take Action</button>
        </section>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Tabs -->
<div x-data x-tabs class="mx-auto max-w-5xl flex flex-col items-start gap-6 sm:flex-row">
    <!-- Tab Headings -->
    <div x-tabs:list class="flex gap-2 sm:w-1/4 sm:shrink-0 sm:flex-col">
        <!-- Tab -->
        <button x-tabs:tab type="button" :class="$tab.isSelected ? 'bg-gray-800/5 text-gray-800' : 'text-gray-700'" class="relative my-px flex h-10 w-full items-center gap-3 rounded-lg border-gray-200 px-3 py-0 text-left text-gray-500 hover:bg-gray-100 hover:text-gray-800 lg:h-8">
            <svg class="size-5 shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0ZM4.501 20.118a7.5 7.5 0 0 1 14.998 0A17.933 17.933 0 0 1 12 21.75c-2.676 0-5.216-.584-7.499-1.632Z"></path>
            </svg>
            Profile
        </button>

        <button x-tabs:tab type="button" :class="$tab.isSelected ? 'bg-gray-800/5 text-gray-800' : 'text-gray-700'" class="relative my-px flex h-10 w-full items-center gap-3 rounded-lg border-gray-200 px-3 py-0 text-left text-gray-500 hover:bg-gray-100 hover:text-gray-800 lg:h-8">
            <svg class="size-5 shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.325.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 0 1 1.37.49l1.296 2.247a1.125 1.125 0 0 1-.26 1.431l-1.003.827c-.293.241-.438.613-.43.992a7.723 7.723 0 0 1 0 .255c-.008.378.137.75.43.991l1.004.827c.424.35.534.955.26 1.43l-1.298 2.247a1.125 1.125 0 0 1-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.47 6.47 0 0 1-.22.128c-.331.183-.581.495-.644.869l-.213 1.281c-.09.543-.56.94-1.11.94h-2.594c-.55 0-1.019-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 0 1-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 0 1-1.369-.49l-1.297-2.247a1.125 1.125 0 0 1 .26-1.431l1.004-.827c.292-.24.437-.613.43-.991a6.932 6.932 0 0 1 0-.255c.007-.38-.138-.751-.43-.992l-1.004-.827a1.125 1.125 0 0 1-.26-1.43l1.297-2.247a1.125 1.125 0 0 1 1.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.086.22-.128.332-.183.582-.495.644-.869l.214-1.28Z"></path>
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z"></path>
            </svg>
            Account
        </button>

        <button x-tabs:tab type="button" :class="$tab.isSelected ? 'bg-gray-800/5 text-gray-800' : 'text-gray-700'" class="relative my-px flex h-10 w-full items-center gap-3 rounded-lg border-gray-200 px-3 py-0 text-left text-gray-500 hover:bg-gray-100 hover:text-gray-800 lg:h-8">
            <svg class="size-5 shrink-0" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" aria-hidden="true">
                <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18.75a60.07 60.07 0 0 1 15.797 2.101c.727.198 1.453-.342 1.453-1.096V18.75M3.75 4.5v.75A.75.75 0 0 1 3 6h-.75m0 0v-.375c0-.621.504-1.125 1.125-1.125H20.25M2.25 6v9m18-10.5v.75c0 .414.336.75.75.75h.75m-1.5-1.5h.375c.621 0 1.125.504 1.125 1.125v9.75c0 .621-.504 1.125-1.125 1.125h-.375m1.5-1.5H21a.75.75 0 0 0-.75.75v.75m0 0H3.75m0 0h-.375a1.125 1.125 0 0 1-1.125-1.125V15m1.5 1.5v-.75A.75.75 0 0 0 3 15h-.75M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm3 0h.008v.008H18V10.5Zm-12 0h.008v.008H6V10.5Z"></path>
            </svg>
            Billing
        </button>
    </div>

    <!-- Tab Panels -->
    <div x-tabs:panels class="rounded-lg border border-gray-200 bg-white">
        <!-- Tab Panel -->
        <section x-tabs:panel class="p-8">
            <h2 class="text-xl font-bold">Profile</h2>
            <p class="mt-2 text-gray-500">Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio, quo sequi error quibusdam quas temporibus animi sapiente eligendi! Deleniti minima velit recusandae iure.</p>
            <button class="mt-5 rounded-md border border-gray-200 px-4 py-2 text-sm">Take Action</button>
        </section>

        <section x-tabs:panel class="p-8">
            <h2 class="text-xl font-bold">Account</h2>
            <p class="mt-2 text-gray-500">Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
            <button class="mt-5 rounded-md border border-gray-200 px-4 py-2 text-sm">Take Action</button>
        </section>

        <section x-tabs:panel class="p-8">
            <h2 class="text-xl font-bold">Billing</h2>
            <p class="mt-2 text-gray-500">Ex culpa esse occaecat aliquip laboris. Culpa aliquip excepteur irure. Tempor ut nisi nulla quis non est magna id ipsum ea sunt commodo aliquip id. Incididunt ipsum nulla ex amet laborum cupidatat mollit et labore dolor.</p>
            <button class="mt-5 rounded-md border border-gray-200 px-4 py-2 text-sm">Take Action</button>
        </section>
    </div>
</div>