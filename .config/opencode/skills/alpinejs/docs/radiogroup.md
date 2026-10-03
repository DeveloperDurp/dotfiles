<!-- Radio Group -->
<div
    x-data="{
        value: 'laravel',
        select(option) { this.value = option },
        isSelected(option) { return this.value === option },
        hasRovingTabindex(option, el) {
            // If this is the first option element and no option has been selected, make it focusable.
            if (this.value === null && Array.from(el.parentElement.children).indexOf(el) === 0) return true

            return this.isSelected(option)
        },
        selectNext(e) {
            let el = e.target
            let siblings = Array.from(el.parentElement.children)
            let index = siblings.indexOf(el)
            let next = siblings[index === siblings.length - 1 ? 0 : index + 1]

            next.click(); next.focus();
        },
        selectPrevious(e) {
            let el = e.target
            let siblings = Array.from(el.parentElement.children)
            let index = siblings.indexOf(el)
            let previous = siblings[index === 0 ? siblings.length - 1 : index - 1]

            previous.click(); previous.focus();
        },
    }"
    @keydown.down.stop.prevent="selectNext"
    @keydown.right.stop.prevent="selectNext"
    @keydown.up.stop.prevent="selectPrevious"
    @keydown.left.stop.prevent="selectPrevious"
    role="radiogroup"
    :aria-labelledby="$id('radio-group-label')"
    x-id="['radio-group-label']"
    class="max-w-2xl w-full"
>
    <!-- Radio Group Label -->
    <label :id="$id('radio-group-label')" role="none" class="sr-only">Backend framework: <span x-text="value"></span></label>

    <div class="flex gap-3 max-sm:flex-col">
        <!-- Option -->
        <div
            x-data="{ option: 'laravel' }"
            @click="select(option)"
            @keydown.enter.stop.prevent="select(option)"
            @keydown.space.stop.prevent="select(option)"
            :aria-checked="isSelected(option)"
            :tabindex="hasRovingTabindex(option, $el) ? 0 : -1"
            :aria-labelledby="$id('radio-option-label')"
            :aria-describedby="$id('radio-option-description')"
            x-id="['radio-option-label', 'radio-option-description']"
            role="radio"
            :class="isSelected(option) ? 'bg-gray-50 border-gray-600' : 'bg-white border-gray-800/15'"
            class="flex flex-1 cursor-pointer justify-between gap-3 rounded-lg border p-4 shadow-sm hover:bg-gray-50"
        >
            <div class="flex flex-1 gap-2">
                <div>
                    <!-- Primary Label -->
                    <p :id="$id('radio-option-label')" class="font-medium text-gray-800">Laravel</p>

                    <!-- Secondary Information -->
                    <div :id="$id('radio-option-description')" class="mt-2 text-sm text-gray-500">
                        A PHP framework built by Taylor Otwell
                    </div>
                </div>
            </div>

            <!-- Checked Indicator -->
            <div
                :class="isSelected(option) ? 'ring-gray-800 bg-gray-800 hover:bg-gray-800 focus:bg-gray-800' : 'ring-gray-300 bg-white'"
                class="flex size-[14px] shrink-0 items-center justify-center rounded-full text-gray-700 shadow-none ring-1 ring-offset-2"
                aria-hidden="true"
            ></div>
        </div>

        <div
            x-data="{ option: 'rails' }"
            @click="select(option)"
            @keydown.enter.stop.prevent="select(option)"
            @keydown.space.stop.prevent="select(option)"
            :aria-checked="isSelected(option)"
            :tabindex="hasRovingTabindex(option, $el) ? 0 : -1"
            :aria-labelledby="$id('radio-option-label')"
            :aria-describedby="$id('radio-option-description')"
            x-id="['radio-option-label', 'radio-option-description']"
            role="radio"
            :class="isSelected(option) ? 'bg-gray-50 border-gray-600' : 'bg-white border-gray-800/15'"
            class="flex flex-1 cursor-pointer justify-between gap-3 rounded-lg border p-4 shadow-sm hover:bg-gray-50"
        >
            <div class="flex flex-1 gap-2">
                <div>
                    <!-- Primary Label -->
                    <p :id="$id('radio-option-label')" class="font-medium text-gray-800">Rails</p>

                    <!-- Secondary Information -->
                    <div :id="$id('radio-option-description')" class="mt-2 text-sm text-gray-500">
                        A Ruby framework built by DHH
                    </div>
                </div>
            </div>

            <!-- Checked Indicator -->
            <div
                :class="isSelected(option) ? 'ring-gray-800 bg-gray-800 hover:bg-gray-800 focus:bg-gray-800' : 'ring-gray-300 bg-white'"
                class="flex size-[14px] shrink-0 items-center justify-center rounded-full text-gray-700 shadow-none ring-1 ring-offset-2"
                aria-hidden="true"
            ></div>
        </div>

        <div
            x-data="{ option: 'phoenix' }"
            @click="select(option)"
            @keydown.enter.stop.prevent="select(option)"
            @keydown.space.stop.prevent="select(option)"
            :aria-checked="isSelected(option)"
            :tabindex="hasRovingTabindex(option, $el) ? 0 : -1"
            :aria-labelledby="$id('radio-option-label')"
            :aria-describedby="$id('radio-option-description')"
            x-id="['radio-option-label', 'radio-option-description']"
            role="radio"
            :class="isSelected(option) ? 'bg-gray-50 border-gray-600' : 'bg-white border-gray-800/15'"
            class="flex flex-1 cursor-pointer justify-between gap-3 rounded-lg border p-4 shadow-sm hover:bg-gray-50"
        >
            <div class="flex flex-1 gap-2">
                <div>
                    <!-- Primary Label -->
                    <p :id="$id('radio-option-label')" class="font-medium text-gray-800">Phoenix</p>

                    <!-- Secondary Information -->
                    <div :id="$id('radio-option-description')" class="mt-2 text-sm text-gray-500">
                        An Elixir framework built by Chris McCord
                    </div>
                </div>
            </div>

            <!-- Checked Indicator -->
            <div
                :class="isSelected(option) ? 'ring-gray-800 bg-gray-800 hover:bg-gray-800 focus:bg-gray-800' : 'ring-gray-300 bg-white'"
                class="flex size-[14px] shrink-0 items-center justify-center rounded-full text-gray-700 shadow-none ring-1 ring-offset-2"
                aria-hidden="true"
            ></div>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Radio -->
<div x-data="{ value: 'standard' }" x-radio x-model="value" class="w-full max-w-xl">
    <!-- Radio Label -->
    <label x-radio:label class="sr-only">Shipping: <span x-text="value"></span></label>

    <div class="flex gap-3 flex-col">
        <!-- Option -->
        <div x-radio:option value="standard"
            class="flex flex-1 cursor-pointer justify-between gap-3 rounded-lg border p-4 shadow-sm hover:bg-gray-50"
            :class="{ 'bg-gray-50 border-gray-600': $radioOption.isChecked, 'bg-white border-gray-800/15': !$radioOption.isChecked }"
        >
            <div class="flex flex-1 gap-2">
                <div class="flex-1">
                    <!-- Primary Label -->
                    <p x-radio:label class="font-medium text-gray-800">Standard</p>

                    <!-- Secondary Information -->
                    <div x-radio:description class="mt-2 text-sm text-gray-500">4-10 business days</div>
                </div>
            </div>
        </div>

        <div x-radio:option value="fast"
            class="flex flex-1 cursor-pointer justify-between gap-3 rounded-lg border p-4 shadow-sm hover:bg-gray-50"
            :class="{ 'bg-gray-50 border-gray-600': $radioOption.isChecked, 'bg-white border-gray-800/15': !$radioOption.isChecked }"
        >
            <div class="flex flex-1 gap-2">
                <div class="flex-1">
                    <p x-radio:label class="font-medium text-gray-800">Fast</p>

                    <div x-radio:description class="mt-2 text-sm text-gray-500">2-5 business days</div>
                </div>
            </div>
        </div>

        <div x-radio:option value="next-day"
            class="flex flex-1 cursor-pointer justify-between gap-3 rounded-lg border p-4 shadow-sm hover:bg-gray-50"
            :class="{ 'bg-gray-50 border-gray-600': $radioOption.isChecked, 'bg-white border-gray-800/15': !$radioOption.isChecked }"
        >
            <div class="flex flex-1 gap-2">
                <div class="flex-1">
                    <p x-radio:label class="font-medium text-gray-800">Next day</p>

                    <div x-radio:description class="mt-2 text-sm text-gray-500">1 business day</div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Radio -->
<div x-data="{ value: 'standard' }" x-radio x-model="value" class="w-full max-w-xl">
    <!-- Radio Label -->
    <label x-radio:label class="sr-only">Shipping: <span x-text="value"></span></label>

    <div class="flex gap-3 max-sm:flex-col">
        <!-- Option -->
        <div x-radio:option value="standard"
            class="flex flex-1 cursor-pointer justify-between gap-3 rounded-lg border p-4 shadow-sm hover:bg-gray-50"
            :class="{ 'bg-gray-50 border-gray-800': $radioOption.isChecked, 'bg-white border-gray-800/15': !$radioOption.isChecked }"
        >
            <div class="flex flex-1 gap-2">
                <div class="flex-1">
                    <!-- Primary Label -->
                    <p x-radio:label class="font-medium text-gray-800">Standard</p>

                    <!-- Secondary Information -->
                    <div x-radio:description class="mt-2 text-sm text-gray-500">4-10 business days</div>
                </div>
            </div>
        </div>

        <div x-radio:option value="fast"
            class="flex flex-1 cursor-pointer justify-between gap-3 rounded-lg border p-4 shadow-sm hover:bg-gray-50"
            :class="{ 'bg-gray-50 border-gray-800': $radioOption.isChecked, 'bg-white border-gray-800/15': !$radioOption.isChecked }"
        >
            <div class="flex flex-1 gap-2">
                <div class="flex-1">
                    <p x-radio:label class="font-medium text-gray-800">Fast</p>

                    <div x-radio:description class="mt-2 text-sm text-gray-500">2-5 business days</div>
                </div>
            </div>
        </div>

        <div x-radio:option value="next-day"
            class="flex flex-1 cursor-pointer justify-between gap-3 rounded-lg border p-4 shadow-sm hover:bg-gray-50"
            :class="{ 'bg-gray-50 border-gray-800': $radioOption.isChecked, 'bg-white border-gray-800/15': !$radioOption.isChecked }"
        >
            <div class="flex flex-1 gap-2">
                <div class="flex-1">
                    <p x-radio:label class="font-medium text-gray-800">Next day</p>

                    <div x-radio:description class="mt-2 text-sm text-gray-500">1 business day</div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Radio -->
<div x-data="{ value: 'standard' }" x-radio x-model="value" class="w-full max-w-2xl">
    <!-- Radio Label -->
    <label x-radio:label class="sr-only">Shipping: <span x-text="value"></span></label>

    <div class="flex gap-3 max-sm:flex-col">
        <!-- Option -->
        <div x-radio:option value="standard"
            class="flex flex-1 cursor-pointer justify-between gap-3 rounded-lg border p-4 shadow-sm hover:bg-gray-50"
            :class="{ 'bg-gray-50 border-gray-800': $radioOption.isChecked, 'bg-white border-gray-800/15': !$radioOption.isChecked }"
        >
            <div class="flex flex-1 gap-2">
                <div class="flex-1">
                    <!-- Primary Label -->
                    <p x-radio:label class="font-medium text-gray-800">Standard</p>

                    <!-- Secondary Information -->
                    <div x-radio:description class="mt-2 text-sm text-gray-500">4-10 business days</div>
                </div>
            </div>

            <!-- Checked Indicator -->
            <div
                class="flex size-[14px] shrink-0 items-center justify-center rounded-full text-gray-700 shadow-none ring-1 ring-offset-2"
                aria-hidden="true"
                :class="{
                    'ring-gray-800 bg-gray-800 hover:bg-gray-800 focus:bg-gray-800': $radioOption.isChecked,
                    'ring-gray-300 bg-white': !$radioOption.isChecked
                }"
            ></div>
        </div>

        <div x-radio:option value="fast"
            class="flex flex-1 cursor-pointer justify-between gap-3 rounded-lg border p-4 shadow-sm hover:bg-gray-50"
            :class="{ 'bg-gray-50 border-gray-800': $radioOption.isChecked, 'bg-white border-gray-800/15': !$radioOption.isChecked }"
        >
            <div class="flex flex-1 gap-2">
                <div class="flex-1">
                    <p x-radio:label class="font-medium text-gray-800">Fast</p>

                    <div x-radio:description class="mt-2 text-sm text-gray-500">2-5 business days</div>
                </div>
            </div>

            <div
                class="flex size-[14px] shrink-0 items-center justify-center rounded-full text-gray-700 shadow-none ring-1 ring-offset-2"
                aria-hidden="true"
                :class="{
                    'ring-gray-800 bg-gray-800 hover:bg-gray-800 focus:bg-gray-800': $radioOption.isChecked,
                    'ring-gray-300 bg-white': !$radioOption.isChecked
                }"
            ></div>
        </div>

        <div x-radio:option value="next-day"
            class="flex flex-1 cursor-pointer justify-between gap-3 rounded-lg border p-4 shadow-sm hover:bg-gray-50"
            :class="{ 'bg-gray-50 border-gray-800': $radioOption.isChecked, 'bg-white border-gray-800/15': !$radioOption.isChecked }"
        >
            <div class="flex flex-1 gap-2">
                <div class="flex-1">
                    <p x-radio:label class="font-medium text-gray-800">Next day</p>

                    <div x-radio:description class="mt-2 text-sm text-gray-500">1 business day</div>
                </div>
            </div>

            <div
                class="flex size-[14px] shrink-0 items-center justify-center rounded-full text-gray-700 shadow-none ring-1 ring-offset-2"
                aria-hidden="true"
                :class="{
                    'ring-gray-800 bg-gray-800 hover:bg-gray-800 focus:bg-gray-800': $radioOption.isChecked,
                    'ring-gray-300 bg-white': !$radioOption.isChecked
                }"
            ></div>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Radio -->
<div x-data="{ value: 'standard' }" x-radio x-model="value" class="w-full max-w-2xl">
    <!-- Radio Label -->
    <label x-radio:label class="sr-only">Shipping: <span x-text="value"></span></label>

    <div class="flex gap-3 max-sm:flex-col">
        <!-- Option -->
        <div x-radio:option value="standard"
            class="flex flex-1 cursor-pointer justify-between gap-3 rounded-lg border p-4 shadow-sm hover:bg-gray-50"
            :class="{ 'bg-gray-50 border-gray-800': $radioOption.isChecked, 'bg-white border-gray-800/15': !$radioOption.isChecked }"
        >
            <svg
                class="shrink-0 size-5 inline-block mt-0.5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"
                :class="{ 'text-gray-800': $radioOption.isChecked, 'text-gray-400': !$radioOption.isChecked }"
            >
                <path d="M6.5 3c-1.051 0-2.093.04-3.125.117A1.49 1.49 0 0 0 2 4.607V10.5h9V4.606c0-.771-.59-1.43-1.375-1.489A41.568 41.568 0 0 0 6.5 3ZM2 12v2.5A1.5 1.5 0 0 0 3.5 16h.041a3 3 0 0 1 5.918 0h.791a.75.75 0 0 0 .75-.75V12H2Z" />
                <path d="M6.5 18a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3ZM13.25 5a.75.75 0 0 0-.75.75v8.514a3.001 3.001 0 0 1 4.893 1.44c.37-.275.61-.719.595-1.227a24.905 24.905 0 0 0-1.784-8.549A1.486 1.486 0 0 0 14.823 5H13.25ZM14.5 18a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3Z" />
            </svg>

            <div class="flex flex-1 gap-2">
                <div class="flex-1">
                    <!-- Primary Label -->
                    <p x-radio:label class="font-medium text-gray-800">Standard</p>

                    <!-- Secondary Information -->
                    <div x-radio:description class="mt-2 text-sm text-gray-500">4-10 business days</div>
                </div>
            </div>
        </div>

        <div x-radio:option value="fast"
            class="flex flex-1 cursor-pointer justify-between gap-3 rounded-lg border p-4 shadow-sm hover:bg-gray-50"
            :class="{ 'bg-gray-50 border-gray-800': $radioOption.isChecked, 'bg-white border-gray-800/15': !$radioOption.isChecked }"
        >
            <svg
                class="shrink-0 size-5 inline-block mt-0.5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"
                :class="{ 'text-gray-800': $radioOption.isChecked, 'text-gray-400': !$radioOption.isChecked }"
            >
              <path d="M10.362 1.093a.75.75 0 0 0-.724 0L2.523 5.018 10 9.143l7.477-4.125-7.115-3.925ZM18 6.443l-7.25 4v8.25l6.862-3.786A.75.75 0 0 0 18 14.25V6.443ZM9.25 18.693v-8.25l-7.25-4v7.807a.75.75 0 0 0 .388.657l6.862 3.786Z" />
            </svg>

            <div class="flex flex-1 gap-2">
                <div class="flex-1">
                    <p x-radio:label class="font-medium text-gray-800">Fast</p>

                    <div x-radio:description class="mt-2 text-sm text-gray-500">2-5 business days</div>
                </div>
            </div>
        </div>

        <div x-radio:option value="next-day"
            class="flex flex-1 cursor-pointer justify-between gap-3 rounded-lg border p-4 shadow-sm hover:bg-gray-50"
            :class="{ 'bg-gray-50 border-gray-800': $radioOption.isChecked, 'bg-white border-gray-800/15': !$radioOption.isChecked }"
        >
            <svg
                class="shrink-0 size-5 inline-block mt-0.5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true"
                :class="{ 'text-gray-800': $radioOption.isChecked, 'text-gray-400': !$radioOption.isChecked }"
            >
              <path fill-rule="evenodd" d="M10 18a8 8 0 1 0 0-16 8 8 0 0 0 0 16Zm.75-13a.75.75 0 0 0-1.5 0v5c0 .414.336.75.75.75h4a.75.75 0 0 0 0-1.5h-3.25V5Z" clip-rule="evenodd" />
            </svg>

            <div class="flex flex-1 gap-2">
                <div class="flex-1">
                    <p x-radio:label class="font-medium text-gray-800">Next day</p>

                    <div x-radio:description class="mt-2 text-sm text-gray-500">1 business day</div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Radio -->
<div x-data="{ value: 'admin' }" x-radio x-model="value" class="mx-auto max-w-xl">
    <!-- Radio Label -->
    <label x-radio:label class="sr-only">Role: <span x-text="value"></span></label>

    <div class="inline-flex h-10 w-full rounded-lg bg-gray-800/5 p-1 lg:max-w-96">
        <!-- Option -->
        <div x-radio:option value="admin"
            :class="$radioOption.isChecked ? 'shadow-sm bg-white text-gray-800' : 'border-transparent'"
            class="flex flex-1 cursor-pointer items-center justify-center whitespace-nowrap rounded-md px-4 font-medium text-gray-600 hover:text-gray-800"
        >Admin</div>

        <div x-radio:option value="editor"
            :class="$radioOption.isChecked ? 'shadow-sm bg-white text-gray-800' : 'border-transparent'"
            class="flex flex-1 cursor-pointer items-center justify-center whitespace-nowrap rounded-md px-4 font-medium text-gray-600 hover:text-gray-800"
        >Editor</div>

        <div x-radio:option value="viewer"
            :class="$radioOption.isChecked ? 'shadow-sm bg-white text-gray-800' : 'border-transparent'"
            class="flex flex-1 cursor-pointer items-center justify-center whitespace-nowrap rounded-md px-4 font-medium text-gray-600 hover:text-gray-800"
        >Viewer</div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Radio -->
<div x-data="{ value: 'admin' }" x-radio x-model="value" class="mx-auto max-w-xl">
    <!-- Radio Label -->
    <label x-radio:label class="sr-only">Role: <span x-text="value"></span></label>

    <div class="inline-flex h-10 w-full rounded-lg bg-gray-800/5 p-1 lg:max-w-96">
        <!-- Option -->
        <div x-radio:option value="admin"
            :class="$radioOption.isChecked ? 'shadow-sm bg-white text-gray-800' : 'border-transparent'"
            class="flex flex-1 cursor-pointer items-center justify-center gap-2 whitespace-nowrap rounded-md px-4 font-medium text-gray-600 hover:text-gray-800"
        >
            <svg class="size-5 shrink-0" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M19 5.5a4.5 4.5 0 0 1-4.791 4.49c-.873-.055-1.808.128-2.368.8l-6.024 7.23a2.724 2.724 0 1 1-3.837-3.837L9.21 8.16c.672-.56.855-1.495.8-2.368a4.5 4.5 0 0 1 5.873-4.575c.324.105.39.51.15.752L13.34 4.66a.455.455 0 0 0-.11.494 3.01 3.01 0 0 0 1.617 1.617c.17.07.363.02.493-.111l2.692-2.692c.241-.241.647-.174.752.15.14.435.216.9.216 1.382ZM4 17a1 1 0 1 0 0-2 1 1 0 0 0 0 2Z" clip-rule="evenodd"></path>
            </svg>
            <span x-radio:label>Admin</span>
        </div>

        <div x-radio:option value="editor"
            :class="$radioOption.isChecked ? 'shadow-sm bg-white text-gray-800' : 'border-transparent'"
            class="flex flex-1 cursor-pointer items-center justify-center gap-2 whitespace-nowrap rounded-md px-4 font-medium text-gray-600 hover:text-gray-800"
        >
            <svg class="size-5 shrink-0" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path d="m5.433 13.917 1.262-3.155A4 4 0 0 1 7.58 9.42l6.92-6.918a2.121 2.121 0 0 1 3 3l-6.92 6.918c-.383.383-.84.685-1.343.886l-3.154 1.262a.5.5 0 0 1-.65-.65Z"></path>
                <path d="M3.5 5.75c0-.69.56-1.25 1.25-1.25H10A.75.75 0 0 0 10 3H4.75A2.75 2.75 0 0 0 2 5.75v9.5A2.75 2.75 0 0 0 4.75 18h9.5A2.75 2.75 0 0 0 17 15.25V10a.75.75 0 0 0-1.5 0v5.25c0 .69-.56 1.25-1.25 1.25h-9.5c-.69 0-1.25-.56-1.25-1.25v-9.5Z"></path>
            </svg>
            <span x-radio:label>Editor</span>
        </div>

        <div x-radio:option value="viewer"
            :class="$radioOption.isChecked ? 'shadow-sm bg-white text-gray-800' : 'border-transparent'"
            class="flex flex-1 cursor-pointer items-center justify-center gap-2 whitespace-nowrap rounded-md px-4 font-medium text-gray-600 hover:text-gray-800"
        >
            <svg class="size-5 shrink-0" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path d="M10 12.5a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z"></path>
                <path fill-rule="evenodd" d="M.664 10.59a1.651 1.651 0 0 1 0-1.186A10.004 10.004 0 0 1 10 3c4.257 0 7.893 2.66 9.336 6.41.147.381.146.804 0 1.186A10.004 10.004 0 0 1 10 17c-4.257 0-7.893-2.66-9.336-6.41ZM14 10a4 4 0 1 1-8 0 4 4 0 0 1 8 0Z" clip-rule="evenodd"></path>
            </svg>
            <span x-radio:label>Viewer</span>
        </div>
    </div>
</div>