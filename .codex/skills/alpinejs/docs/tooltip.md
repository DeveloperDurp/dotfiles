<!-- Tippy.js -->
<!-- https://atomiks.github.io/tippyjs/v6 -->
<script src="https://unpkg.com/@popperjs/core@2"></script>
<script src="https://unpkg.com/tippy.js@6"></script>

<!-- Usage -->
<div class="flex items-center justify-center gap-2">
    <button
        x-data
        x-tooltip="I am a tooltip!"
        type="button"
        class="relative flex items-center justify-center gap-2 whitespace-nowrap rounded-lg border border-gray-200 bg-white px-4 py-2 text-gray-800 shadow-sm hover:border-gray-200 hover:bg-gray-50"
    >
        Hover over me
    </button>

    <button
        x-data
        @click="$tooltip('I am a tooltip!')"
        type="button"
        class="relative flex items-center justify-center gap-2 whitespace-nowrap rounded-lg border border-gray-200 bg-white px-4 py-2 text-gray-800 shadow-sm hover:border-gray-200 hover:bg-gray-50"
    >
        Click me
    </button>
</div>

<!-- Source -->
<script>
    document.addEventListener('alpine:init', () => {
        // Magic: $tooltip
        Alpine.magic('tooltip', el => message => {
            let instance = tippy(el, { content: message, trigger: 'manual' })

            instance.show()

            setTimeout(() => {
                instance.hide()

                setTimeout(() => instance.destroy(), 150)
            }, 2000)
        })

        // Directive: x-tooltip
        Alpine.directive('tooltip', (el, { expression }) => {
            tippy(el, { content: expression })
        })
    })
</script>