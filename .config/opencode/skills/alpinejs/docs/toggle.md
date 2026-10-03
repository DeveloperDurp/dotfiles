<!-- Toggle -->
<div
    x-data="{ value: false }"
    class="flex min-w-0 gap-4 items-center"
    x-id="['toggle-label']"
>
    <input type="hidden" name="sendNotifications" :value="value">

    <!-- Label -->
    <label
        @click="$refs.toggle.click(); $refs.toggle.focus()"
        :id="$id('toggle-label')"
        class="font-medium text-gray-800 select-none"
    >
        Send notifications
    </label>

    <!-- Button -->
    <button
        x-ref="toggle"
        @click="value = ! value"
        type="button"
        role="switch"
        :aria-checked="value"
        :aria-labelledby="$id('toggle-label')"
        :class="value ? 'bg-gray-800' : 'bg-gray-800/20'"
        class="relative inline-flex h-5 w-8 items-center rounded-full outline-offset-2 transition"
    >
        <span
            :class="value ? 'translate-x-[15px]' : 'translate-x-[3px]'"
            class="bg-white size-3.5 rounded-full transition shadow-md"
            aria-hidden="true"
        ></span>
    </button>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Toggle -->
<div x-data="{ value: false }" x-switch:group class="flex min-w-0 gap-4 items-center">
    <!-- Label -->
    <label x-switch:label class="font-medium text-gray-800 select-none">Send notifications</label>

    <!-- Switch -->
    <button x-switch x-model="value"
        :class="$switch.isChecked ? 'bg-gray-800' : 'bg-gray-800/20'"
        class="relative inline-flex h-5 w-8 items-center rounded-full outline-offset-2 transition"
    >
        <span
            :class="$switch.isChecked ? 'translate-x-[15px]' : 'translate-x-[3px]'"
            class="bg-white size-3.5 rounded-full transition shadow-md"
            aria-hidden="true"
        ></span>
    </button>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<fieldset  class="w-full lg:max-w-96">
    <legend class="font-medium text-gray-800">Email notifications</legend>

    <div class="flex flex-col *:py-1 first:*:pt-0 last:*:pb-0 mt-4 w-full">
        <!-- Toggle -->
        <div x-data="{ value: true }" x-switch:group class="flex min-w-0 gap-x-3 gap-y-1.5 w-full items-center">
            <!-- Switch -->
            <button
                x-switch
                x-model="value"
                :class="$switch.isChecked ? 'bg-gray-800' : 'bg-gray-800/20'"
                class="relative inline-flex h-5 w-8 items-center rounded-full outline-offset-2 transition"
            >
                <span
                    :class="$switch.isChecked ? 'translate-x-[15px]' : 'translate-x-[3px]'"
                    class="bg-white size-3.5 rounded-full transition shadow-md"
                ></span>
            </button>

            <div class="flex-1 min-w-0">
                <!-- Label -->
                <label x-switch:label class="text-gray-800 select-none">Communication emails</label>
            </div>
        </div>

        <div x-data="{ value: false }" x-switch:group class="flex min-w-0 gap-x-3 gap-y-1.5 w-full items-center">
            <button
                x-switch
                x-model="value"
                :class="$switch.isChecked ? 'bg-gray-800' : 'bg-gray-800/20'"
                class="relative inline-flex h-5 w-8 items-center rounded-full outline-offset-2 transition"
            >
                <span
                    :class="$switch.isChecked ? 'translate-x-[15px]' : 'translate-x-[3px]'"
                    class="bg-white size-3.5 rounded-full transition shadow-md"
                ></span>
            </button>

            <div class="flex-1 min-w-0">
                <label x-switch:label class="text-gray-800 select-none">Marketing emails</label>
            </div>
        </div>

        <div x-data="{ value: false }" x-switch:group class="flex min-w-0 gap-x-3 gap-y-1.5 w-full items-center">
            <button
                x-switch
                x-model="value"
                :class="$switch.isChecked ? 'bg-gray-800' : 'bg-gray-800/20'"
                class="relative inline-flex h-5 w-8 items-center rounded-full outline-offset-2 transition"
            >
                <span
                    :class="$switch.isChecked ? 'translate-x-[15px]' : 'translate-x-[3px]'"
                    class="bg-white size-3.5 rounded-full transition shadow-md"
                ></span>
            </button>

            <div class="flex-1 min-w-0">
                <label x-switch:label class="text-gray-800 select-none">Security emails</label>
            </div>
        </div>

        <div x-data="{ value: false }" x-switch:group class="flex min-w-0 gap-x-3 gap-y-1.5 w-full items-center">
            <button
                x-switch
                x-model="value"
                :class="$switch.isChecked ? 'bg-gray-800' : 'bg-gray-800/20'"
                class="relative inline-flex h-5 w-8 items-center rounded-full outline-offset-2 transition"
            >
                <span
                    :class="$switch.isChecked ? 'translate-x-[15px]' : 'translate-x-[3px]'"
                    class="bg-white size-3.5 rounded-full transition shadow-md"
                ></span>
            </button>

            <div class="flex-1 min-w-0">
                <label x-switch:label class="text-gray-800 select-none">Social emails</label>
            </div>
        </div>
    </div>
</fieldset>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<fieldset  class="w-full lg:max-w-96">
    <legend class="font-medium text-gray-800">Email notifications</legend>

    <div class="flex flex-col divide-y divide-gray-800/5 *:py-4 first:*:pt-0 last:*:pb-0 mt-4 w-full">
        <!-- Toggle -->
        <div x-data="{ value: true }" x-switch:group class="flex min-w-0 gap-x-3 gap-y-1.5 w-full">
            <div class="flex-1 min-w-0">
                <!-- Label -->
                <label x-switch:label class="text-gray-800 select-none">Communication emails</label>

                <!-- Secondary Information -->
                <p x-switch:description class="text-gray-600 mt-2 text-sm">Receive emails about your account activity.</p>
            </div>

            <!-- Switch -->
            <button
                x-switch
                x-model="value"
                :class="$switch.isChecked ? 'bg-gray-800' : 'bg-gray-800/20'"
                class="relative inline-flex h-5 w-8 items-center rounded-full outline-offset-2 transition"
            >
                <span
                    :class="$switch.isChecked ? 'translate-x-[15px]' : 'translate-x-[3px]'"
                    class="bg-white size-3.5 rounded-full transition shadow-md"
                ></span>
            </button>
        </div>

        <div x-data="{ value: false }" x-switch:group class="flex min-w-0 gap-x-3 gap-y-1.5 w-full">
            <div class="flex-1 min-w-0">
                <label x-switch:label class="text-gray-800 select-none">Marketing emails</label>

                <p x-switch:description class="text-gray-600 mt-2 text-sm">Receive emails about new products, features, and more.</p>
            </div>

            <button
                x-switch
                x-model="value"
                :class="$switch.isChecked ? 'bg-gray-800' : 'bg-gray-800/20'"
                class="relative inline-flex h-5 w-8 items-center rounded-full outline-offset-2 transition"
            >
                <span
                    :class="$switch.isChecked ? 'translate-x-[15px]' : 'translate-x-[3px]'"
                    class="bg-white size-3.5 rounded-full transition shadow-md"
                ></span>
            </button>
        </div>

        <div x-data="{ value: false }" x-switch:group class="flex min-w-0 gap-x-3 gap-y-1.5 w-full">
            <div class="flex-1 min-w-0">
                <label x-switch:label class="text-gray-800 select-none">Social emails</label>

                <p x-switch:description class="text-gray-600 mt-2 text-sm">Receive emails for friend requests, follows, and more.</p>
            </div>

            <button
                x-switch
                x-model="value"
                :class="$switch.isChecked ? 'bg-gray-800' : 'bg-gray-800/20'"
                class="relative inline-flex h-5 w-8 items-center rounded-full outline-offset-2 transition"
            >
                <span
                    :class="$switch.isChecked ? 'translate-x-[15px]' : 'translate-x-[3px]'"
                    class="bg-white size-3.5 rounded-full transition shadow-md"
                ></span>
            </button>
        </div>

        <div x-data="{ value: false }" x-switch:group class="flex min-w-0 gap-x-3 gap-y-1.5 w-full">
            <div class="flex-1 min-w-0">
                <label x-switch:label class="text-gray-800 select-none">Security emails</label>

                <p x-switch:description class="text-gray-600 mt-2 text-sm">Receive emails about your account activity and security.</p>
            </div>

            <button
                x-switch
                x-model="value"
                :class="$switch.isChecked ? 'bg-gray-800' : 'bg-gray-800/20'"
                class="relative inline-flex h-5 w-8 items-center rounded-full outline-offset-2 transition"
            >
                <span
                    :class="$switch.isChecked ? 'translate-x-[15px]' : 'translate-x-[3px]'"
                    class="bg-white size-3.5 rounded-full transition shadow-md"
                ></span>
            </button>
        </div>
    </div>
</fieldset>