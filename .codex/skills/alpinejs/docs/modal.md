<div x-data="{ open: false }" class="flex justify-center">
    <!-- Trigger -->
    <span x-on:click="open = true">
        <button type="button" class="relative flex items-center justify-center gap-2 whitespace-nowrap rounded-lg border border-gray-200 bg-white px-4 py-2 text-gray-800 shadow-sm hover:border-gray-200 hover:bg-gray-50">
            Open modal
        </button>
    </span>

    <!-- Modal -->
    <div
        x-show="open"
        style="display: none"
        x-on:keydown.escape.prevent.stop="open = false"
        role="dialog"
        aria-modal="true"
        x-id="['modal-title']"
        :aria-labelledby="$id('modal-title')"
        class="fixed inset-0 z-10 overflow-y-auto"
    >
        <!-- Overlay -->
        <div x-show="open" x-transition.opacity class="fixed inset-0 bg-black/25"></div>

        <!-- Panel -->
        <div
            x-show="open" x-transition
            x-on:click="open = false"
            class="relative flex min-h-screen items-center justify-center p-4"
        >
            <div
                x-on:click.stop
                x-trap.noscroll.inert="open"
                class="relative min-w-96 max-w-xl rounded-xl bg-white p-6 shadow-lg"
            >
                <!-- Title -->
                <h2 class="font-medium text-gray-800" :id="$id('modal-title')">Confirm</h2>

                <!-- Content -->
                <p class="mt-2 text-gray-500 max-w-xs">Are you sure you want to learn how to create an awesome modal?</p>

                <!-- Buttons -->
                <div class="mt-6 flex justify-end space-x-2">
                    <button type="button" x-on:click="open = false" class="relative flex items-center justify-center gap-2 whitespace-nowrap rounded-lg border border-transparent bg-transparent px-4 py-2 text-gray-800 hover:bg-gray-800/10">
                        Cancel
                    </button>

                    <button type="button" x-on:click="open = false" class="relative flex items-center justify-center gap-2 whitespace-nowrap rounded-lg border border-transparent bg-gray-800 px-4 py-2 text-white hover:bg-gray-900">
                        Confirm
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<div x-data="{ open: false }" class="flex justify-center">
    <!-- Trigger -->
    <span x-on:click="open = true">
        <button type="button" class="relative flex items-center justify-center gap-2 whitespace-nowrap rounded-lg border border-gray-200 bg-white px-4 py-2 text-gray-800 shadow-sm hover:border-gray-200 hover:bg-gray-50">Open dialog</button>
    </span>

    <!-- Modal -->
    <div x-dialog x-model="open" x-cloak class="fixed inset-0 z-10 overflow-y-auto">
        <!-- Overlay -->
        <div x-dialog:overlay x-transition.opacity class="fixed inset-0 bg-black/25"></div>

        <!-- Panel -->
        <div class="relative flex min-h-screen items-center justify-center p-4">
            <div x-dialog:panel x-transition class="relative min-w-96 max-w-xl rounded-xl bg-white p-6 shadow-lg">
                <!-- Close Button -->
                <div class="absolute right-0 top-0 mr-4 mt-4">
                    <button type="button" @click="$dialog.close()" class="relative inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md bg-transparent p-1.5 font-medium text-gray-400 hover:bg-gray-800/10 hover:text-gray-800">
                        <span class="sr-only">Close modal</span>
                        <svg class="size-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                            <path d="M6.28 5.22a.75.75 0 0 0-1.06 1.06L8.94 10l-3.72 3.72a.75.75 0 1 0 1.06 1.06L10 11.06l3.72 3.72a.75.75 0 1 0 1.06-1.06L11.06 10l3.72-3.72a.75.75 0 0 0-1.06-1.06L10 8.94 6.28 5.22Z"></path>
                        </svg>
                    </button>
                </div>

                <!-- Body -->
                <div>
                    <!-- Title -->
                    <h2 x-dialog:title class="font-medium text-gray-800">Ready to go live?</h2>

                    <!-- Content -->
                    <div class="mt-2 text-gray-500 max-w-xs">
                        <p>Once published, your content will be visible to everyone.</p>
                    </div>
                </div>

                <!-- Footer -->
                <div class="mt-6 flex justify-end space-x-2">
                    <button type="button" x-on:click="$dialog.close()" class="relative flex items-center justify-center gap-2 whitespace-nowrap rounded-lg border border-transparent bg-transparent px-4 py-2 text-gray-800 hover:bg-gray-800/10">Cancel</button>

                    <button type="button" x-on:click="$dialog.close()" class="relative flex items-center justify-center gap-2 whitespace-nowrap rounded-lg border border-transparent bg-gray-800 px-4 py-2 text-white hover:bg-gray-900">Publish</button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<div x-data="{ open: false }" class="flex justify-center">
    <!-- Trigger -->
    <span x-on:click="open = true">
        <button type="button" class="relative flex items-center justify-center gap-2 whitespace-nowrap rounded-lg border border-gray-200 bg-white px-4 py-2 text-gray-800 shadow-sm hover:border-gray-200 hover:bg-gray-50">
            Open flyout
        </button>
    </span>

    <!-- Flyout -->
    <div
        x-dialog
        x-model="open"
        x-cloak
        class="fixed inset-0 overflow-hidden z-10">
        <!-- Overlay -->
        <div x-dialog:overlay x-transition.opacity class="fixed inset-0 bg-black/25"></div>

        <!-- Panel -->
        <div class="fixed inset-y-0 right-0 max-w-lg w-full max-h-dvh min-h-dvh">
            <div
                x-dialog:panel
                x-transition:enter="transition ease-out duration-300"
                x-transition:enter-start="translate-x-full"
                x-transition:enter-end="translate-x-0"
                x-transition:leave="transition ease-in duration-300"
                x-transition:leave-start="translate-x-0"
                x-transition:leave-end="translate-x-full"
                class="h-full w-full">
                <div class="h-full flex flex-col bg-white shadow-lg overflow-y-auto p-8">
                    <!-- Close Button -->
                    <div class="absolute right-0 top-0 mr-4 mt-4">
                        <button type="button" @click="$dialog.close()" class="relative inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md bg-transparent p-1.5 font-medium text-gray-400 hover:bg-gray-800/10 hover:text-gray-800">
                            <span class="sr-only">Close modal</span>
                            <svg class="size-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                <path d="M6.28 5.22a.75.75 0 0 0-1.06 1.06L8.94 10l-3.72 3.72a.75.75 0 1 0 1.06 1.06L10 11.06l3.72 3.72a.75.75 0 1 0 1.06-1.06L11.06 10l3.72-3.72a.75.75 0 0 0-1.06-1.06L10 8.94 6.28 5.22Z"></path>
                            </svg>
                        </button>
                    </div>

                    <!-- Body -->
                    <div class="space-y-6">
                        <!-- Title -->
                        <h2 x-dialog:title class="font-medium text-gray-800">Edit post</h2>

                        <div class="space-y-3">
                            <div class="rounded-md bg-gray-200/70 h-5 w-[300px]"></div>
                            <div class="rounded-md bg-gray-200/70 h-5 w-[250px]"></div>
                            <div class="rounded-md bg-gray-200/70 h-5 w-[200px]"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Include these scripts somewhere on the page: -->
<script defer src="https://unpkg.com/@alpinejs/ui@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/@alpinejs/focus@3.x.x/dist/cdn.min.js"></script>
<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>

<div x-data="{ open: false }" class="flex justify-center">
    <!-- Trigger -->
    <span x-on:click="open = true">
        <button type="button" class="relative flex items-center justify-center gap-2 whitespace-nowrap rounded-lg border border-gray-200 bg-white px-4 py-2 text-gray-800 shadow-sm hover:border-gray-200 hover:bg-gray-50">
            Open flyout
        </button>
    </span>

    <!-- Flyout -->
    <div
        x-dialog
        x-model="open"
        x-cloak
        class="fixed inset-0 overflow-hidden z-10"
    >
        <!-- Overlay -->
        <div x-dialog:overlay x-transition.opacity class="fixed inset-0 bg-black/25"></div>

        <!-- Panel -->
        <div class="fixed inset-y-0 left-0 max-w-lg w-full max-h-dvh min-h-dvh">
            <div
                x-dialog:panel
                x-transition:enter="transition ease-out duration-300"
                x-transition:enter-start="-translate-x-full"
                x-transition:enter-end="translate-x-0"
                x-transition:leave="transition ease-in duration-300"
                x-transition:leave-start="translate-x-0"
                x-transition:leave-end="-translate-x-full"
                class="h-full w-full"
            >
                <div class="h-full flex flex-col bg-white shadow-lg overflow-y-auto p-8">
                    <!-- Close Button -->
                    <div class="absolute right-0 top-0 mr-4 mt-4">
                        <button type="button" @click="$dialog.close()" class="relative inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md bg-transparent p-1.5 font-medium text-gray-400 hover:bg-gray-800/10 hover:text-gray-800">
                            <span class="sr-only">Close modal</span>
                            <svg class="size-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                <path d="M6.28 5.22a.75.75 0 0 0-1.06 1.06L8.94 10l-3.72 3.72a.75.75 0 1 0 1.06 1.06L10 11.06l3.72 3.72a.75.75 0 1 0 1.06-1.06L11.06 10l3.72-3.72a.75.75 0 0 0-1.06-1.06L10 8.94 6.28 5.22Z"></path>
                            </svg>
                        </button>
                    </div>

                    <!-- Body -->
                    <div class="space-y-6">
                        <!-- Title -->
                        <h2 x-dialog:title class="font-medium text-gray-800">Edit post</h2>

                        <div class="space-y-2.5">
                            <div class="rounded-md bg-gray-200/70 h-5 w-[300px]"></div>
                            <div class="rounded-md bg-gray-200/70 h-5 w-[250px]"></div>
                            <div class="rounded-md bg-gray-200/70 h-5 w-[200px]"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>