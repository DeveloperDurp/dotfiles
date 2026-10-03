<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<div
    x-data="{
        query: '',
        selected: null,
        industries: [
            { id: 1, name: 'Photography', disabled: false },
            { id: 2, name: 'Design services', disabled: false },
            { id: 3, name: 'Web development', disabled: true },
            { id: 4, name: 'Accounting', disabled: false },
            { id: 5, name: 'Legal services', disabled: false },
            { id: 6, name: 'Consulting', disabled: false },
            { id: 7, name: 'Other', disabled: false },
        ],
        get filteredIndustries() {
            return this.query === ''
                ? this.industries
                : this.industries.filter((industry) => {
                    return industry.name.toLowerCase().includes(this.query.toLowerCase())
                })
        },
    }"
    class="max-w-xs w-full">
    <!-- Combobox -->
    <div x-combobox x-model="selected" class="relative w-full">
        <div class="group w-full block relative">
            <!-- Combobox Input -->
            <input
                x-combobox:input
                :display-value="industry => industry.name"
                @change="query = $event.target.value;"
                class="focus:outline-none focus:ring-0 px-3 py-2 rounded-lg border border-gray-200 bg-white shadow-sm w-full placeholder-gray-400"
                placeholder="Choose industry..."
                autocomplete="off" />

            <!-- Combobox Button -->
            <button x-combobox:button class="absolute inset-y-0 right-0 flex items-center pr-2">
                <!-- Heroicons up/down -->
                <svg class="shrink-0 size-5 text-gray-300 group-hover:text-gray-800" viewBox="0 0 20 20" fill="none" stroke="currentColor" aria-hidden="true">
                    <path d="M7 7l3-3 3 3m0 6l-3 3-3-3" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
                </svg>
            </button>
        </div>

        <!-- Combobox Options -->
        <div x-combobox:options x-cloak class="absolute right-0 z-10 mt-2 max-h-80 w-full overflow-y-scroll overscroll-contain rounded-lg border border-gray-200 bg-white p-1.5 shadow-sm outline-none">
            <ul class="">
                <template x-for="industry in filteredIndustries" :key="industry.id">
                    <!-- Combobox Option -->
                    <li
                        x-combobox:option
                        :value="industry"
                        :disabled="industry.disabled"
                        :class="{
                            'bg-gray-100': $comboboxOption.isActive,
                            'text-gray-800': ! $comboboxOption.isActive && ! $comboboxOption.isDisabled,
                            'text-gray-400 cursor-not-allowed': $comboboxOption.isDisabled,
                        }"
                        class="group flex w-full cursor-default items-center rounded-md px-2 py-1.5 transition-colors">
                        <div class="w-6 shrink-0">
                            <svg class="size-5 shrink-0" x-show="$comboboxOption.isSelected" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                <path fill-rule="evenodd" d="M16.704 4.153a.75.75 0 0 1 .143 1.052l-8 10.5a.75.75 0 0 1-1.127.075l-4.5-4.5a.75.75 0 0 1 1.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 0 1 1.05-.143Z" clip-rule="evenodd"></path>
                            </svg>
                        </div>

                        <span x-text="industry.name"></span>
                    </li>
                </template>
            </ul>

            <p x-show="filteredIndustries.length == 0" class="px-2 py-1.5 text-gray-600">No results founds.</p>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<div
    x-data="{
        query: '',
        selected: [],
        industries: [
            { id: 1, name: 'Photography', disabled: false },
            { id: 2, name: 'Design services', disabled: false },
            { id: 3, name: 'Web development', disabled: true },
            { id: 4, name: 'Accounting', disabled: false },
            { id: 5, name: 'Legal services', disabled: false },
            { id: 6, name: 'Consulting', disabled: false },
            { id: 7, name: 'Other', disabled: false },
        ],
        get filteredIndustries() {
            return this.query === ''
                ? this.industries
                : this.industries.filter((industry) => {
                    return industry.name.toLowerCase().includes(this.query.toLowerCase())
                })
        },
        remove(industry) {
            this.selected = this.selected.filter((i) => i !== industry)
        },
    }"
    class="max-w-xs w-full"
>
    <!--
        If using it in conjunction with `@tailwindcss/forms`
        make sure to overwrite the global styles for
        `multiple` by `p-0 bg-transparent border-0`
    -->
    <!-- Combobox -->
    <div x-combobox x-model="selected" multiple by="id" class="relative w-full bg-transparent border-none p-0">
        <div x-show="selected.length" class="mt-1 mb-4 flex flex-wrap items-center gap-2">
            <template x-for="selectedIndustry in selected" :key="selectedIndustry.id">
                <div class="inline-flex items-center font-medium whitespace-nowrap text-sm py-1 rounded-md px-2 text-gray-700 bg-gray-400/15">
                    <span x-text="selectedIndustry.name"></span>

                    <!-- Heroicons mini x-mark -->
                    <button type="button" class="p-1 -my-1 -mr-1 opacity-50 hover:opacity-100" x-on:click.prevent="remove(selectedIndustry)">
                        <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" aria-hidden="true">
                            <path d="M5.28 4.22a.75.75 0 0 0-1.06 1.06L6.94 8l-2.72 2.72a.75.75 0 1 0 1.06 1.06L8 9.06l2.72 2.72a.75.75 0 1 0 1.06-1.06L9.06 8l2.72-2.72a.75.75 0 0 0-1.06-1.06L8 6.94 5.28 4.22Z"></path>
                        </svg>
                    </button>
                </div>
            </template>
        </div>

        <div class="mt-1 group w-full block relative">
            <!-- Combobox Input -->
            <input
                x-combobox:input
                @change="query = $event.target.value;"
                class="focus:outline-none focus:ring-0 px-3 py-2 rounded-lg border border-gray-200 bg-white shadow-sm w-full placeholder-gray-400"
                placeholder="Choose industries..."
                autocomplete="off"
            />

            <!-- Combobox Button -->
            <button x-combobox:button class="absolute inset-y-0 right-0 flex items-center pr-2">
                <!-- Heroicons up/down -->
                <svg class="shrink-0 size-5 text-gray-300 group-hover:text-gray-800" viewBox="0 0 20 20" fill="none" stroke="currentColor" aria-hidden="true"><path d="M7 7l3-3 3 3m0 6l-3 3-3-3" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" /></svg>
            </button>
        </div>

        <!-- Combobox Options -->
        <div x-combobox:options x-cloak class="absolute right-0 z-10 mt-2 max-h-80 w-full overflow-y-scroll overscroll-contain rounded-lg border border-gray-200 bg-white p-1.5 shadow-sm outline-none">
            <ul class="">
                <template x-for="industry in filteredIndustries" :key="industry.id" hidden>
                    <li
                        x-combobox:option
                        :value="industry"
                        :disabled="industry.disabled"
                        :class="{
                            'bg-gray-100': $comboboxOption.isActive,
                            'text-gray-800': ! $comboboxOption.isActive && ! $comboboxOption.isDisabled,
                            'text-gray-400 cursor-not-allowed': $comboboxOption.isDisabled,
                        }"
                        class="group flex w-full cursor-default items-center rounded-md px-2 py-1.5 transition-colors"
                    >
                        <div class="w-6 shrink-0">
                            <svg class="size-5 shrink-0" x-show="$comboboxOption.isSelected" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                <path fill-rule="evenodd" d="M16.704 4.153a.75.75 0 0 1 .143 1.052l-8 10.5a.75.75 0 0 1-1.127.075l-4.5-4.5a.75.75 0 0 1 1.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 0 1 1.05-.143Z" clip-rule="evenodd"></path>
                            </svg>
                        </div>

                        <span x-text="industry.name"></span>
                    </li>
                </template>
            </ul>

            <!-- Empty Message -->
            <p x-show="filteredIndustries.length === 0" class="px-2 py-1.5 text-gray-600">No results founds.</p>
        </div>
    </div>
</div>