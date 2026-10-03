<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Popover -->
<div x-data x-popover class="relative">

    <!-- Popover Button -->
    <button x-popover:button type="button" class="relative flex items-center whitespace-nowrap justify-center gap-2 py-2 rounded-lg shadow-sm bg-white hover:bg-gray-50 text-gray-800 border border-gray-200 hover:border-gray-200 px-4">
        Account

        <!-- Heroicon: micro chevron-down -->
        <svg  class="size-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M4.22 6.22a.75.75 0 0 1 1.06 0L8 8.94l2.72-2.72a.75.75 0 1 1 1.06 1.06l-3.25 3.25a.75.75 0 0 1-1.06 0L4.22 7.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
        </svg>
    </button>

    <!-- Popover Panel -->
    <div
        x-popover:panel
        x-transition.origin.top.left
        class="absolute left-0 min-w-48 rounded-lg shadow-sm mt-2 z-10 origin-top-left bg-white p-1.5 outline-none border border-gray-200"
        x-cloak
    >
        <a
            href="#profile"
            class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50"
        >
            Profile
        </a>
        <a
            href="#settings"
            class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50"
        >
            Settings
        </a>
        <a
            href="#billing"
            class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50"
        >
            Billing
        </a>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Popover Group -->
<div x-popover:group class="flex items-center justify-center gap-1">

    <!-- Popover -->
    <div x-data x-popover class="relative">

        <!-- Popover Button -->
        <button x-popover:button type="button" class="relative flex items-center whitespace-nowrap justify-center gap-2 py-2 rounded-lg text-gray-800 hover:bg-gray-800/10 px-4">
            <svg class="shrink-0 size-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M6 3.75A2.75 2.75 0 0 1 8.75 1h2.5A2.75 2.75 0 0 1 14 3.75v.443c.572.055 1.14.122 1.706.2C17.053 4.582 18 5.75 18 7.07v3.469c0 1.126-.694 2.191-1.83 2.54-1.952.599-4.024.921-6.17.921s-4.219-.322-6.17-.921C2.694 12.73 2 11.665 2 10.539V7.07c0-1.321.947-2.489 2.294-2.676A41.047 41.047 0 0 1 6 4.193V3.75Zm6.5 0v.325a41.622 41.622 0 0 0-5 0V3.75c0-.69.56-1.25 1.25-1.25h2.5c.69 0 1.25.56 1.25 1.25ZM10 10a1 1 0 0 0-1 1v.01a1 1 0 0 0 1 1h.01a1 1 0 0 0 1-1V11a1 1 0 0 0-1-1H10Z" clip-rule="evenodd" />
                <path d="M3 15.055v-.684c.126.053.255.1.39.142 2.092.642 4.313.987 6.61.987 2.297 0 4.518-.345 6.61-.987.135-.041.264-.089.39-.142v.684c0 1.347-.985 2.53-2.363 2.686a41.454 41.454 0 0 1-9.274 0C3.985 17.585 3 16.402 3 15.055Z" />
            </svg>

            <span>Workspace</span>

            <!-- Heroicon: micro chevron-down -->
            <svg class="shrink-0 size-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M4.22 6.22a.75.75 0 0 1 1.06 0L8 8.94l2.72-2.72a.75.75 0 1 1 1.06 1.06l-3.25 3.25a.75.75 0 0 1-1.06 0L4.22 7.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
            </svg>
        </button>

        <!-- Popover Panel -->
        <div
            x-popover:panel
            x-transition.origin.top.left
            class="absolute left-0 min-w-48 rounded-lg shadow-sm mt-2 z-10 origin-top-left bg-white p-1.5 outline-none border border-gray-200"
            x-cloak>
            <a
                href="#contracts"
                class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50">
                Contracts
            </a>
            <a
                href="#documents"
                class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50">
                Documents
            </a>
            <a
                href="#history"
                class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50">
                History
            </a>
        </div>
    </div>

    <div role="none" class="border-0 bg-gray-800/10 self-stretch w-px my-2.5"></div>

    <div x-data x-popover class="relative">
        <button x-popover:button type="button" class="relative flex items-center whitespace-nowrap justify-center gap-2 py-2 rounded-lg text-gray-800 hover:bg-gray-800/10 px-4">
            Account

            <!-- Heroicon: micro chevron-down -->
            <svg class="size-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M4.22 6.22a.75.75 0 0 1 1.06 0L8 8.94l2.72-2.72a.75.75 0 1 1 1.06 1.06l-3.25 3.25a.75.75 0 0 1-1.06 0L4.22 7.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
            </svg>
        </button>

        <div
            x-popover:panel
            x-transition.origin.top.left
            class="absolute left-0 min-w-48 rounded-lg shadow-sm mt-2 z-10 origin-top-left bg-white p-1.5 outline-none border border-gray-200"
            x-cloak>
            <a
                href="#profile"
                class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50">
                Profile
            </a>
            <a
                href="#settings"
                class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50">
                Settings
            </a>
            <a
                href="#billing"
                class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50">
                Billing
            </a>
        </div>
    </div>

    <div x-data x-popover class="relative">
        <button x-popover:button type="button" class="relative flex items-center whitespace-nowrap justify-center gap-2 py-2 rounded-lg text-gray-800 hover:bg-gray-800/10 px-4">
            Favorites

            <!-- Heroicon: micro chevron-down -->
            <svg class="size-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M4.22 6.22a.75.75 0 0 1 1.06 0L8 8.94l2.72-2.72a.75.75 0 1 1 1.06 1.06l-3.25 3.25a.75.75 0 0 1-1.06 0L4.22 7.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
            </svg>
        </button>

        <div
            x-popover:panel
            x-transition.origin.top.left
            class="absolute left-0 min-w-48 rounded-lg shadow-sm mt-2 z-10 origin-top-left bg-white p-1.5 outline-none border border-gray-200"
            x-cloak>
            <a
                href="#marketing-site"
                class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50">
                Marketing site
            </a>
            <a
                href="#android-app"
                class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50">
                Android app
            </a>
            <a
                href="#brand-guidelines"
                class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50">
                Brand guidelines
            </a>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<div class="flex items-center justify-center">
    <button type="button" class="relative flex items-center whitespace-nowrap justify-center gap-2 py-2 rounded-l-lg shadow-sm bg-white hover:bg-gray-50 text-gray-800 border border-gray-200 hover:border-gray-200 px-4">
        <svg class="shrink-0 size-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
          <path fill-rule="evenodd" d="M16.704 4.153a.75.75 0 0 1 .143 1.052l-8 10.5a.75.75 0 0 1-1.127.075l-4.5-4.5a.75.75 0 0 1 1.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 0 1 1.05-.143Z" clip-rule="evenodd" />
        </svg>
        Save
    </button>

    <!-- Popover -->
    <div x-data x-popover class="relative">

        <!-- Popover Button -->
        <button x-popover:button type="button" class="relative flex items-center whitespace-nowrap justify-center gap-2 rounded-r-lg shadow-sm bg-white hover:bg-gray-50 text-gray-800 border border-l-0 border-gray-200 hover:border-gray-200 p-2.5">
            <span class="sr-only">Options</span>

            <!-- Heroicon: chevron-down -->
            <svg class="size-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M5.22 8.22a.75.75 0 0 1 1.06 0L10 11.94l3.72-3.72a.75.75 0 1 1 1.06 1.06l-4.25 4.25a.75.75 0 0 1-1.06 0L5.22 9.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
            </svg>
        </button>

        <!-- Popover Panel -->
        <div
            x-popover:panel
            x-transition.origin.top.right
            class="absolute right-0 min-w-48 rounded-lg shadow-sm mt-2 z-10 origin-top-left bg-white p-1.5 outline-none border border-gray-200"
            x-cloak
        >
            <a
                href="#create"
                class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50"
            >
                New post
            </a>
            <a
                href="#duplicate"
                class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50"
            >
                Duplicate
            </a>
            <a
                href="#delete"
                class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50"
            >
                Delete
            </a>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<!-- Popover -->
<div x-data x-popover class="relative max-w-full">

    <!-- Popover Button -->
    <button x-popover:button class="group flex items-center rounded-lg w-full p-1 hover:bg-gray-800/10">
        <div class="shrink-0 size-8 bg-gray-400 rounded overflow-hidden">
            <img src="https://ui-avatars.com/api/?name=Adam+Lazzara">
        </div>

        <span class="text-gray-500 group-hover:text-gray-800 font-medium truncate ml-4">
            Adam Lazzara
        </span>

        <!-- Heroicon: micro chevron-down -->
        <svg  class="ml-2 shrink-0 size-4 text-gray-400 group-hover:text-gray-800" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16" fill="currentColor" aria-hidden="true">
           <path fill-rule="evenodd" d="M4.22 6.22a.75.75 0 0 1 1.06 0L8 8.94l2.72-2.72a.75.75 0 1 1 1.06 1.06l-3.25 3.25a.75.75 0 0 1-1.06 0L4.22 7.28a.75.75 0 0 1 0-1.06Z" clip-rule="evenodd" />
        </svg>
    </button>

    <!-- Popover Panel -->
    <div
        x-popover:panel
        x-transition.origin.top.left
        x-cloak
        class="absolute left-0 min-w-48 rounded-lg shadow-sm mt-2 z-10 origin-top-left bg-white p-1.5 outline-none border border-gray-200"
    >
        <a
            href="#account"
            class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50"
        >
            <svg class="shrink-0 size-5 mr-2 text-gray-400 group-focus-visible:text-gray-800 group-hover:text-gray-800" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path d="M10 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6ZM3.465 14.493a1.23 1.23 0 0 0 .41 1.412A9.957 9.957 0 0 0 10 18c2.31 0 4.438-.784 6.131-2.1.43-.333.604-.903.408-1.41a7.002 7.002 0 0 0-13.074.003Z" />
            </svg>
            Account
        </a>
        <a
            href="#profile"
            class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50"
        >
            <svg class="shrink-0 size-5 mr-2 text-gray-400 group-focus-visible:text-gray-800 group-hover:text-gray-800" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path d="M2.879 7.121A3 3 0 0 0 7.5 6.66a2.997 2.997 0 0 0 2.5 1.34 2.997 2.997 0 0 0 2.5-1.34 3 3 0 1 0 4.622-3.78l-.293-.293A2 2 0 0 0 15.415 2H4.585a2 2 0 0 0-1.414.586l-.292.292a3 3 0 0 0 0 4.243ZM3 9.032a4.507 4.507 0 0 0 4.5-.29A4.48 4.48 0 0 0 10 9.5a4.48 4.48 0 0 0 2.5-.758 4.507 4.507 0 0 0 4.5.29V16.5h.25a.75.75 0 0 1 0 1.5h-4.5a.75.75 0 0 1-.75-.75v-3.5a.75.75 0 0 0-.75-.75h-2.5a.75.75 0 0 0-.75.75v3.5a.75.75 0 0 1-.75.75h-4.5a.75.75 0 0 1 0-1.5H3V9.032Z" />
            </svg>
            Profile
        </a>
        <a
            href="#billing"
            class="group px-2 py-1.5 w-full flex items-center rounded-md  transition-colors text-left text-gray-800 focus-visible:bg-gray-50 hover:bg-gray-50"
        >
            <svg class="shrink-0 size-5 mr-2 text-gray-400 group-focus-visible:text-gray-800 group-hover:text-gray-800" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M2.5 4A1.5 1.5 0 0 0 1 5.5V6h18v-.5A1.5 1.5 0 0 0 17.5 4h-15ZM19 8.5H1v6A1.5 1.5 0 0 0 2.5 16h15a1.5 1.5 0 0 0 1.5-1.5v-6ZM3 13.25a.75.75 0 0 1 .75-.75h1.5a.75.75 0 0 1 0 1.5h-1.5a.75.75 0 0 1-.75-.75Zm4.75-.75a.75.75 0 0 0 0 1.5h3.5a.75.75 0 0 0 0-1.5h-3.5Z" clip-rule="evenodd" />
            </svg>
            Billing
        </a>
        <a
            href="#logout"
            class="group px-2 py-1.5 w-full flex items-center rounded-md transition-colors text-left text-gray-800 focus-visible:bg-red-50 focus-visible:text-red-600 hover:bg-red-50 hover:text-red-600"
        >
            <svg class="shrink-0 size-5 mr-2 text-gray-400 group-focus-visible:text-red-600 group-hover:text-red-600" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M3 4.25A2.25 2.25 0 0 1 5.25 2h5.5A2.25 2.25 0 0 1 13 4.25v2a.75.75 0 0 1-1.5 0v-2a.75.75 0 0 0-.75-.75h-5.5a.75.75 0 0 0-.75.75v11.5c0 .414.336.75.75.75h5.5a.75.75 0 0 0 .75-.75v-2a.75.75 0 0 1 1.5 0v2A2.25 2.25 0 0 1 10.75 18h-5.5A2.25 2.25 0 0 1 3 15.75V4.25Z" clip-rule="evenodd" />
                <path fill-rule="evenodd" d="M6 10a.75.75 0 0 1 .75-.75h9.546l-1.048-.943a.75.75 0 1 1 1.004-1.114l2.5 2.25a.75.75 0 0 1 0 1.114l-2.5 2.25a.75.75 0 1 1-1.004-1.114l1.048-.943H6.75A.75.75 0 0 1 6 10Z" clip-rule="evenodd" />
            </svg>
            Logout
        </a>
    </div>
</div>