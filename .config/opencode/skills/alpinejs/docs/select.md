<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<div
    x-data="{
        value: null,
        industries: [
            { id: 1, name: 'Photography', disabled: false },
            { id: 2, name: 'Design services', disabled: false },
            { id: 3, name: 'Web development', disabled: true },
            { id: 4, name: 'Accounting', disabled: false },
            { id: 5, name: 'Legal services', disabled: false },
            { id: 6, name: 'Consulting', disabled: false },
            { id: 7, name: 'Other', disabled: false },
        ],
    }"
>
    <!-- Listbox -->
    <div x-listbox x-model="value" class="relative">
        <!-- Listbox Label -->
        <label x-listbox:label class="sr-only">Industry</label>

        <!-- Listbox Button -->
        <button x-listbox:button class="group flex w-64 items-center justify-between gap-2 rounded-lg border border-gray-200 bg-white px-3 py-2 shadow-sm">
            <span x-text="value ? value.name : 'Choose industry...'" class="truncate" :class="{ 'text-gray-400': !$listbox.value }"></span>

            <!-- Heroicons up/down -->
            <svg class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd"></path>
            </svg>
        </button>

        <!-- Listbox Options -->
        <ul x-listbox:options x-cloak class="absolute right-0 z-10 mt-2 max-h-80 w-full overflow-y-scroll overscroll-contain rounded-lg border border-gray-200 bg-white p-1.5 shadow-sm outline-none">
            <template x-for="industry in industries" :key="industry.id">
                <!-- Listbox Option -->
                <li
                    x-listbox:option
                    :value="industry"
                    :disabled="industry.disabled"
                    :class="{
                        'bg-gray-100': $listboxOption.isActive,
                        'text-gray-800': ! $listboxOption.isActive && ! $listboxOption.isDisabled,
                        'text-gray-400 cursor-not-allowed': $listboxOption.isDisabled,
                    }"
                    class="group flex w-full cursor-default items-center rounded-md px-2 py-1.5 transition-colors"
                >
                    <div class="w-6 shrink-0">
                        <svg class="size-5 shrink-0" x-show="$listboxOption.isSelected" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                            <path fill-rule="evenodd" d="M16.704 4.153a.75.75 0 0 1 .143 1.052l-8 10.5a.75.75 0 0 1-1.127.075l-4.5-4.5a.75.75 0 0 1 1.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 0 1 1.05-.143Z" clip-rule="evenodd"></path>
                        </svg>
                    </div>
                    <span x-text="industry.name"></span>
                </li>
            </template>
        </ul>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<div
    x-data="{
        value: null,
        roles: [
            {
                id: 1,
                name: 'Owner',
                disabled: false,
                icon: '<svg class=&quot;shrink-0 size-5&quot; xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 20 20&quot; fill=&quot;currentColor&quot; aria-hidden=&quot;true&quot;><path fill-rule=&quot;evenodd&quot; d=&quot;M9.661 2.237a.531.531 0 0 1 .678 0 11.947 11.947 0 0 0 7.078 2.749.5.5 0 0 1 .479.425c.069.52.104 1.05.104 1.59 0 5.162-3.26 9.563-7.834 11.256a.48.48 0 0 1-.332 0C5.26 16.564 2 12.163 2 7c0-.538.035-1.069.104-1.589a.5.5 0 0 1 .48-.425 11.947 11.947 0 0 0 7.077-2.75Zm4.196 5.954a.75.75 0 0 0-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 1 0-1.06 1.061l2.5 2.5a.75.75 0 0 0 1.137-.089l4-5.5Z&quot; clip-rule=&quot;evenodd&quot;/></svg>'
            },
            {
                id: 2,
                name: 'Administrator',
                disabled: false,
                icon: '<svg class=&quot;shrink-0 size-5&quot; xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 20 20&quot; fill=&quot;currentColor&quot; aria-hidden=&quot;true&quot;><path fill-rule=&quot;evenodd&quot; d=&quot;M8 7a5 5 0 1 1 3.61 4.804l-1.903 1.903A1 1 0 0 1 9 14H8v1a1 1 0 0 1-1 1H6v1a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1v-2a1 1 0 0 1 .293-.707L8.196 8.39A5.002 5.002 0 0 1 8 7Zm5-3a.75.75 0 0 0 0 1.5A1.5 1.5 0 0 1 14.5 7 .75.75 0 0 0 16 7a3 3 0 0 0-3-3Z&quot; clip-rule=&quot;evenodd&quot;></path></svg>'
            },
            {
                id: 3,
                name: 'Member',
                disabled: false,
                icon: '<svg class=&quot;shrink-0 size-5&quot; xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 20 20&quot; fill=&quot;currentColor&quot; aria-hidden=&quot;true&quot;><path d=&quot;M10 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6ZM3.465 14.493a1.23 1.23 0 0 0 .41 1.412A9.957 9.957 0 0 0 10 18c2.31 0 4.438-.784 6.131-2.1.43-.333.604-.903.408-1.41a7.002 7.002 0 0 0-13.074.003Z&quot;></path></svg>'
            },
            {
                id: 4,
                name: 'Viewer',
                disabled: false,
                icon: '<svg class=&quot;shrink-0 size-5&quot; xmlns=&quot;http://www.w3.org/2000/svg&quot; viewBox=&quot;0 0 20 20&quot; fill=&quot;currentColor&quot; aria-hidden=&quot;true&quot;><path d=&quot;M10 12.5a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z&quot;></path><path fill-rule=&quot;evenodd&quot; d=&quot;M.664 10.59a1.651 1.651 0 0 1 0-1.186A10.004 10.004 0 0 1 10 3c4.257 0 7.893 2.66 9.336 6.41.147.381.146.804 0 1.186A10.004 10.004 0 0 1 10 17c-4.257 0-7.893-2.66-9.336-6.41ZM14 10a4 4 0 1 1-8 0 4 4 0 0 1 8 0Z&quot; clip-rule=&quot;evenodd&quot;></path></svg>'
            },
        ],
    }"
>
    <!-- Listbox -->
    <div x-listbox x-model="value" class="relative">
        <!-- Listbox Label -->
        <label x-listbox:label class="sr-only">Role</label>

        <!-- Listbox Button -->
        <button x-listbox:button class="group flex w-64 items-center justify-between gap-2 rounded-lg border border-gray-200 bg-white px-3 py-2 shadow-sm">
            <span class="flex items-center gap-2 flex-1">
                <span x-html="value && value.icon" x-show="value.name" x-cloak class="text-gray-800"></span>

                <span x-text="value ? value.name : 'Choose role...'" class="truncate" :class="{ 'text-gray-400': !$listbox.value }"></span>
            </span>

            <!-- Heroicons up/down -->
            <svg class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd"></path>
            </svg>
        </button>

        <!-- Listbox Options -->
        <ul x-listbox:options x-cloak class="absolute right-0 z-10 mt-2 max-h-80 w-full overflow-y-scroll overscroll-contain rounded-lg border border-gray-200 bg-white p-1.5 shadow-sm outline-none">
            <template x-for="role in roles" :key="role.id">
                <!-- Listbox Option -->
                <li
                    x-listbox:option
                    :value="role"
                    :disabled="role.disabled"
                    :class="{
                        'bg-gray-100': $listboxOption.isActive,
                        'text-gray-800': ! $listboxOption.isActive && ! $listboxOption.isDisabled,
                        'text-gray-400 cursor-not-allowed': $listboxOption.isDisabled,
                    }"
                    class="group flex w-full cursor-default items-center rounded-md px-2 py-1.5 transition-colors"
                >
                    <div class="flex items-center gap-2 flex-1">
                        <span x-html="role.icon" class="text-gray-400 group-hover:text-gray-800"></span>

                        <span x-text="role.name"></span>
                    </div>

                    <div class="w-6 shrink-0">
                        <svg class="size-5 shrink-0" x-show="$listboxOption.isSelected" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                            <path fill-rule="evenodd" d="M16.704 4.153a.75.75 0 0 1 .143 1.052l-8 10.5a.75.75 0 0 1-1.127.075l-4.5-4.5a.75.75 0 0 1 1.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 0 1 1.05-.143Z" clip-rule="evenodd"></path>
                        </svg>
                    </div>
                </li>
            </template>
        </ul>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<div
    x-data="{
        values: [],
        industries: [
            { id: 1, name: 'Photography', disabled: false },
            { id: 2, name: 'Design services', disabled: false },
            { id: 3, name: 'Web development', disabled: true },
            { id: 4, name: 'Accounting', disabled: false },
            { id: 5, name: 'Legal services', disabled: false },
            { id: 6, name: 'Consulting', disabled: false },
            { id: 7, name: 'Other', disabled: false },
        ],
        get label(){
            if(this.values.length === 0){
                return 'Choose industries...';
            }
            return this.values.length === 1 ? this.values[0].name : `${this.values.length} selected`;
        }
    }"
>
    <!--
        If using it in conjunction with `@tailwindcss/forms`
        make sure to overwrite the global styles for
        `multiple` by `p-0 bg-transparent border-0`
    -->
    <!-- Listbox -->
    <div x-listbox x-model="values" class="relative p-0 bg-transparent border-0" multiple>
        <!-- Listbox Label -->
        <label x-listbox:label class="sr-only">Industry</label>

        <!-- Listbox Button -->
        <button x-listbox:button class="group flex w-64 items-center justify-between gap-2 rounded-lg border border-gray-200 bg-white px-3 py-2 shadow-sm">
            <span x-text="label" class="truncate" :class="{ 'text-gray-400': $listbox.value.length === 0 }"></span>

            <!-- Heroicons up/down -->
            <svg class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd"></path>
            </svg>
        </button>

        <!-- Listbox Options -->
        <ul x-listbox:options x-cloak class="absolute right-0 z-10 mt-2 max-h-80 w-full overflow-y-scroll overscroll-contain rounded-lg border border-gray-200 bg-white p-1.5 shadow-sm outline-none">
            <template x-for="industry in industries" :key="industry.id">
                <!-- Listbox Option -->
                <li
                    x-listbox:option
                    :value="industry"
                    :disabled="industry.disabled"
                    :class="{
                        'bg-gray-100': $listboxOption.isActive,
                        'text-gray-800': ! $listboxOption.isActive && ! $listboxOption.isDisabled,
                        'text-gray-400 cursor-not-allowed': $listboxOption.isDisabled,
                    }"
                    class="group flex w-full cursor-default items-center rounded-md px-2 py-1.5 transition-colors"
                >
                    <div class="w-6 shrink-0">
                        <svg class="size-5 shrink-0" x-show="$listboxOption.isSelected" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                            <path fill-rule="evenodd" d="M16.704 4.153a.75.75 0 0 1 .143 1.052l-8 10.5a.75.75 0 0 1-1.127.075l-4.5-4.5a.75.75 0 0 1 1.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 0 1 1.05-.143Z" clip-rule="evenodd"></path>
                        </svg>
                    </div>

                    <span x-text="industry.name"></span>
                </li>
            </template>
        </ul>
    </div>
</div>