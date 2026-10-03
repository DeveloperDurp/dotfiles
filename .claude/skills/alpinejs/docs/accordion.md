<div x-data="{ active: 2 }" class="mx-auto min-h-[16rem] w-full max-w-3xl">
    <div x-data="{
        id: 1,
        get expanded() {
            return this.active === this.id
        },
        set expanded(value) {
            this.active = value ? this.id : null
        },
    }" role="region" class="block border-b border-gray-800/10 pb-4 pt-4 first:pt-0 last:border-b-0 last:pb-0">
        <h2>
            <button
                type="button"
                x-on:click="expanded = !expanded"
                :aria-expanded="expanded"
                class="group flex w-full items-center justify-between text-left font-medium text-gray-800"
            >
                <span class="flex-1">Question #1</span>

                <!-- Heroicons mini chevron-up -->
                <svg x-show="expanded" x-cloak class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M9.47 6.47a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 1 1-1.06 1.06L10 8.06l-3.72 3.72a.75.75 0 0 1-1.06-1.06l4.25-4.25Z" clip-rule="evenodd"></path>
                </svg>

                <!-- Heroicons mini chevron-down -->
                <svg x-show="!expanded" class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" data-slot="icon">
                    <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd"></path>
                </svg>
            </button>
        </h2>

        <div x-show="expanded" x-collapse>
            <div class="pt-2 text-gray-600 max-w-xl">Lorem ipsum dolor sit amet consectetur adipisicing elit. In magnam quod natus deleniti architecto eaque consequuntur ex, illo neque iste repellendus modi, quasi ipsa commodi saepe? Provident ipsa nulla earum.</div>
        </div>
    </div>

    <div x-data="{
        id: 2,
        get expanded() {
            return this.active === this.id
        },
        set expanded(value) {
            this.active = value ? this.id : null
        },
    }" role="region" class="block border-b border-gray-800/10 pb-4 pt-4 first:pt-0 last:border-b-0 last:pb-0">
        <h2>
            <button
                type="button"
                x-on:click="expanded = !expanded"
                :aria-expanded="expanded"
                class="group flex w-full items-center justify-between text-left font-medium text-gray-800"
            >
                <span class="flex-1">Question #2</span>

                <!-- Heroicons mini chevron-up -->
                <svg x-show="expanded" x-cloak class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M9.47 6.47a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 1 1-1.06 1.06L10 8.06l-3.72 3.72a.75.75 0 0 1-1.06-1.06l4.25-4.25Z" clip-rule="evenodd"></path>
                </svg>

                <!-- Heroicons mini chevron-down -->
                <svg x-show="!expanded" class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" data-slot="icon">
                    <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd"></path>
                </svg>
            </button>
        </h2>

        <div x-show="expanded" x-collapse>
            <div class="pt-2 text-gray-600 max-w-xl">Lorem ipsum dolor sit amet consectetur adipisicing elit. In magnam quod natus deleniti architecto eaque consequuntur ex, illo neque iste repellendus modi, quasi ipsa commodi saepe? Provident ipsa nulla earum.</div>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/collapse@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<div x-data class="mx-auto min-h-[16rem] w-full max-w-3xl">
    <!-- Disclosure -->
    <div x-disclosure class="block border-b border-gray-800/10 pb-4 pt-4 first:pt-0 last:border-b-0 last:pb-0">
        <!-- Disclosure Button -->
        <button
            x-disclosure:button
            type="button"
            class="group flex w-full items-center justify-between text-left font-medium text-gray-800">
            <span class="flex-1">What's your refund policy?</span>

            <!-- Heroicons mini chevron-up -->
            <svg x-show="$disclosure.isOpen" x-cloak class="shrink-0 text-gray-300 size-5 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M9.47 6.47a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 1 1-1.06 1.06L10 8.06l-3.72 3.72a.75.75 0 0 1-1.06-1.06l4.25-4.25Z" clip-rule="evenodd"></path>
            </svg>

            <!-- Heroicons mini chevron-down -->
            <svg x-show="!$disclosure.isOpen" class="shrink-0 text-gray-300 size-5 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd"></path>
            </svg>
        </button>

        <!-- Disclosure Panel -->
        <div x-disclosure:panel>
            <div class="pt-2 text-gray-600 max-w-xl">If you are not satisfied with your purchase, we offer a 30-day money-back guarantee. Please contact our support team for assistance.</div>
        </div>
    </div>

    <div x-disclosure class="block border-b border-gray-800/10 pb-4 pt-4 first:pt-0 last:border-b-0 last:pb-0">
        <button
            x-disclosure:button
            type="button"
            class="group flex w-full items-center justify-between text-left font-medium text-gray-800">
            <span class="flex-1">Do you offer any discounts for bulk purchases?</span>

            <svg x-show="$disclosure.isOpen" x-cloak class="shrink-0 text-gray-300 size-5 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M9.47 6.47a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 1 1-1.06 1.06L10 8.06l-3.72 3.72a.75.75 0 0 1-1.06-1.06l4.25-4.25Z" clip-rule="evenodd"></path>
            </svg>

            <svg x-show="!$disclosure.isOpen" class="shrink-0 text-gray-300 size-5 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd"></path>
            </svg>
        </button>

        <div x-disclosure:panel>
            <div class="pt-2 text-gray-600 max-w-xl">Yes, we offer special discounts for bulk orders. Please reach out to our sales team with your requirements.</div>
        </div>
    </div>

    <div x-disclosure class="block border-b border-gray-800/10 pb-4 pt-4 first:pt-0 last:border-b-0 last:pb-0">
        <button
            x-disclosure:button
            type="button"
            class="group flex w-full items-center justify-between text-left font-medium text-gray-800">
            <span class="flex-1">How do I track my order?</span>

            <svg x-show="$disclosure.isOpen" x-cloak class="shrink-0 text-gray-300 size-5 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M9.47 6.47a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 1 1-1.06 1.06L10 8.06l-3.72 3.72a.75.75 0 0 1-1.06-1.06l4.25-4.25Z" clip-rule="evenodd"></path>
            </svg>

            <svg x-show="!$disclosure.isOpen" class="shrink-0 text-gray-300 size-5 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd"></path>
            </svg>
        </button>

        <div x-disclosure:panel>
            <div class="pt-2 text-gray-600 max-w-xl">Once your order is shipped, you will receive an email with a tracking number. Use this number to track your order on our website.</div>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/collapse@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<div x-data class="mx-auto min-h-[16rem] w-full max-w-3xl">
    <!-- Disclosure -->
    <div x-disclosure class="block border-b border-gray-800/10 pb-4 pt-4 first:pt-0 last:border-b-0 last:pb-0">
        <!-- Disclosure Button -->
        <button
            x-disclosure:button
            type="button"
            class="group flex w-full items-center justify-between text-left font-medium text-gray-800">
            <span class="flex-1">What's your refund policy?</span>

            <!-- Heroicons mini chevron-up -->
            <svg x-show="$disclosure.isOpen" x-cloak class="shrink-0 text-gray-300 size-5 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M9.47 6.47a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 1 1-1.06 1.06L10 8.06l-3.72 3.72a.75.75 0 0 1-1.06-1.06l4.25-4.25Z" clip-rule="evenodd"></path>
            </svg>

            <!-- Heroicons mini chevron-down -->
            <svg x-show="!$disclosure.isOpen" class="shrink-0 text-gray-300 size-5 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd"></path>
            </svg>
        </button>

        <!-- Disclosure Panel -->
        <div x-disclosure:panel x-collapse>
            <div class="pt-2 text-gray-600 max-w-xl">If you are not satisfied with your purchase, we offer a 30-day money-back guarantee. Please contact our support team for assistance.</div>
        </div>
    </div>

    <div x-disclosure class="block border-b border-gray-800/10 pb-4 pt-4 first:pt-0 last:border-b-0 last:pb-0">
        <button
            x-disclosure:button
            type="button"
            class="group flex w-full items-center justify-between text-left font-medium text-gray-800">
            <span class="flex-1">Do you offer any discounts for bulk purchases?</span>

            <svg x-show="$disclosure.isOpen" x-cloak class="shrink-0 text-gray-300 size-5 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M9.47 6.47a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 1 1-1.06 1.06L10 8.06l-3.72 3.72a.75.75 0 0 1-1.06-1.06l4.25-4.25Z" clip-rule="evenodd"></path>
            </svg>

            <svg x-show="!$disclosure.isOpen" class="shrink-0 text-gray-300 size-5 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd"></path>
            </svg>
        </button>

        <div x-disclosure:panel x-collapse>
            <div class="pt-2 text-gray-600 max-w-xl">Yes, we offer special discounts for bulk orders. Please reach out to our sales team with your requirements.</div>
        </div>
    </div>

    <div x-disclosure class="block border-b border-gray-800/10 pb-4 pt-4 first:pt-0 last:border-b-0 last:pb-0">
        <button
            x-disclosure:button
            type="button"
            class="group flex w-full items-center justify-between text-left font-medium text-gray-800">
            <span class="flex-1">How do I track my order?</span>

            <svg x-show="$disclosure.isOpen" x-cloak class="shrink-0 text-gray-300 size-5 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M9.47 6.47a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 1 1-1.06 1.06L10 8.06l-3.72 3.72a.75.75 0 0 1-1.06-1.06l4.25-4.25Z" clip-rule="evenodd"></path>
            </svg>

            <svg x-show="!$disclosure.isOpen" class="shrink-0 text-gray-300 size-5 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd"></path>
            </svg>
        </button>

        <div x-disclosure:panel x-collapse>
            <div class="pt-2 text-gray-600 max-w-xl">Once your order is shipped, you will receive an email with a tracking number. Use this number to track your order on our website.</div>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/collapse@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<div x-data="{ active: null }" class="mx-auto min-h-[16rem] w-full max-w-3xl">
    <!-- Disclosure -->
    <div
        x-disclosure
        x-data="{
            id: 1,
            get expanded() {
                return this.active === this.id
            },
            set expanded(id) {
                this.active = id ? this.id : null
            },
        }"
        x-model="expanded"
        class="block border-b border-gray-800/10 pb-4 pt-4 first:pt-0 last:border-b-0 last:pb-0"
    >
        <!-- Disclosure Button -->
        <button x-disclosure:button type="button" class="group flex w-full items-center justify-between text-left font-medium text-gray-800">
            <span class="flex-1">What's your refund policy?</span>

            <!-- Heroicons mini chevron-up -->
            <svg x-show="$disclosure.isOpen" x-cloak class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M9.47 6.47a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 1 1-1.06 1.06L10 8.06l-3.72 3.72a.75.75 0 0 1-1.06-1.06l4.25-4.25Z" clip-rule="evenodd"></path>
            </svg>

            <!-- Heroicons mini chevron-down -->
            <svg x-show="!$disclosure.isOpen" class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" data-slot="icon">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd"></path>
            </svg>
        </button>

        <!-- Disclosure Panel -->
        <div x-disclosure:panel x-collapse>
            <div class="pt-2 text-gray-600 max-w-xl">If you are not satisfied with your purchase, we offer a 30-day money-back guarantee. Please contact our support team for assistance.</div>
        </div>
    </div>

    <div
        x-disclosure
        x-data="{
            id: 2,
            get expanded() {
                return this.active === this.id
            },
            set expanded(id) {
                this.active = id ? this.id : null
            },
        }"
        x-model="expanded"
        class="block border-b border-gray-800/10 pb-4 pt-4 first:pt-0 last:border-b-0 last:pb-0"
    >
        <button x-disclosure:button type="button" class="group flex w-full items-center justify-between text-left font-medium text-gray-800">
            <span class="flex-1">Do you offer any discounts for bulk purchases?</span>

            <svg x-show="$disclosure.isOpen" x-cloak class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M9.47 6.47a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 1 1-1.06 1.06L10 8.06l-3.72 3.72a.75.75 0 0 1-1.06-1.06l4.25-4.25Z" clip-rule="evenodd"></path>
            </svg>

            <svg x-show="!$disclosure.isOpen" class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" data-slot="icon">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd"></path>
            </svg>
        </button>

        <div x-disclosure:panel x-collapse>
            <div class="pt-2 text-gray-600 max-w-xl">Yes, we offer special discounts for bulk orders. Please reach out to our sales team with your requirements.</div>
        </div>
    </div>

    <div
        x-disclosure
        x-data="{
            id: 3,
            get expanded() {
                return this.active === this.id
            },
            set expanded(id) {
                this.active = id ? this.id : null
            },
        }"
        x-model="expanded"
        class="block border-b border-gray-800/10 pb-4 pt-4 first:pt-0 last:border-b-0 last:pb-0"
    >
        <button x-disclosure:button type="button" class="group flex w-full items-center justify-between text-left font-medium text-gray-800">
            <span class="flex-1">How do I track my order?</span>

            <svg x-show="$disclosure.isOpen" x-cloak class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M9.47 6.47a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 1 1-1.06 1.06L10 8.06l-3.72 3.72a.75.75 0 0 1-1.06-1.06l4.25-4.25Z" clip-rule="evenodd"></path>
            </svg>

            <svg x-show="!$disclosure.isOpen" class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" data-slot="icon">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd"></path>
            </svg>
        </button>

        <div x-disclosure:panel x-collapse>
            <div class="pt-2 text-gray-600 max-w-xl">Once your order is shipped, you will receive an email with a tracking number. Use this number to track your order on our website.</div>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/collapse@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<div x-data class="mx-auto min-h-[16rem] w-full max-w-3xl">
    <!-- Disclosure -->
    <div
        x-disclosure
        class="block border-b border-gray-800/10 pb-4 pt-4 first:pt-0 last:border-b-0 last:pb-0">
        <!-- Disclosure Button -->
        <button x-disclosure:button type="button" class="group flex w-full items-center justify-between text-left font-medium text-gray-800 gap-2">
            <!-- Heroicons mini chevron-down -->
            <svg x-show="$disclosure.isOpen" x-cloak class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
            </svg>

            <!-- Heroicons mini chevron-down -->
            <svg x-show="!$disclosure.isOpen" class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M8.22 5.22a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 0 1 0 1.06l-4.25 4.25a.75.75 0 0 1-1.06-1.06L11.94 10 8.22 6.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
            </svg>

            <span class="flex-1">What's your refund policy?</span>
        </button>

        <!-- Disclosure Panel -->
        <div x-disclosure:panel x-collapse>
            <div class="pt-2 text-gray-600 max-w-xl">If you are not satisfied with your purchase, we offer a 30-day money-back guarantee. Please contact our support team for assistance.</div>
        </div>
    </div>

    <div
        x-disclosure
        class="block border-b border-gray-800/10 pb-4 pt-4 first:pt-0 last:border-b-0 last:pb-0">
        <button x-disclosure:button type="button" class="group flex w-full items-center justify-between text-left font-medium text-gray-800 gap-2">
            <!-- Heroicons mini chevron-down -->
            <svg x-show="$disclosure.isOpen" x-cloak class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
            </svg>

            <!-- Heroicons mini chevron-down -->
            <svg x-show="!$disclosure.isOpen" class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M8.22 5.22a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 0 1 0 1.06l-4.25 4.25a.75.75 0 0 1-1.06-1.06L11.94 10 8.22 6.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
            </svg>

            <span class="flex-1">Do you offer any discounts for bulk purchases?</span>
        </button>

        <div x-disclosure:panel x-collapse>
            <div class="pt-2 text-gray-600 max-w-xl">Yes, we offer special discounts for bulk orders. Please reach out to our sales team with your requirements.</div>
        </div>
    </div>

    <div
        x-disclosure
        class="block border-b border-gray-800/10 pb-4 pt-4 first:pt-0 last:border-b-0 last:pb-0">
        <button x-disclosure:button type="button" class="group flex w-full items-center justify-between text-left font-medium text-gray-800 gap-2">
            <!-- Heroicons mini chevron-down -->
            <svg x-show="$disclosure.isOpen" x-cloak class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
            </svg>

            <!-- Heroicons mini chevron-down -->
            <svg x-show="!$disclosure.isOpen" class="size-5 shrink-0 text-gray-300 group-hover:text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M8.22 5.22a.75.75 0 0 1 1.06 0l4.25 4.25a.75.75 0 0 1 0 1.06l-4.25 4.25a.75.75 0 0 1-1.06-1.06L11.94 10 8.22 6.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
            </svg>

            <span class="flex-1">How do I track my order?</span>
        </button>

        <div x-disclosure:panel x-collapse>
            <div class="pt-2 text-gray-600 max-w-xl">Once your order is shipped, you will receive an email with a tracking number. Use this number to track your order on our website.</div>
        </div>
    </div>
</div>