<script src="https://unpkg.com/smoothscroll-polyfill@0.4.4/dist/smoothscroll.js"></script>

<div
    x-data="{
        skip: 3,
        atBeginning: false,
        atEnd: false,
        next() {
            this.to((current, offset) => current + (offset * this.skip))
        },
        prev() {
            this.to((current, offset) => current - (offset * this.skip))
        },
        to(strategy) {
            let slider = this.$refs.slider
            let current = slider.scrollLeft
            let offset = slider.firstElementChild.getBoundingClientRect().width
            slider.scrollTo({ left: strategy(current, offset), behavior: 'smooth' })
        },
        focusableWhenVisible: {
            'x-intersect:enter'() {
                this.$el.removeAttribute('tabindex')
            },
            'x-intersect:leave'() {
                this.$el.setAttribute('tabindex', '-1')
            },
        },
        disableNextAndPreviousButtons: {
            'x-intersect:enter.threshold.05'() {
                let slideEls = this.$el.parentElement.children

                // If this is the first slide.
                if (slideEls[0] === this.$el) {
                    this.atBeginning = true
                // If this is the last slide.
                } else if (slideEls[slideEls.length-1] === this.$el) {
                    this.atEnd = true
                }
            },
            'x-intersect:leave.threshold.05'() {
                let slideEls = this.$el.parentElement.children

                // If this is the first slide.
                if (slideEls[0] === this.$el) {
                    this.atBeginning = false
                // If this is the last slide.
                } else if (slideEls[slideEls.length-1] === this.$el) {
                    this.atEnd = false
                }
            },
        },
    }"
    class="flex w-full flex-col"
>
    <div
        x-on:keydown.right="next"
        x-on:keydown.left="prev"
        tabindex="0"
        role="region"
        aria-labelledby="carousel-label"
        class="flex space-x-6"
    >
        <h2 id="carousel-label" class="sr-only" hidden>Carousel</h2>

        <!-- Prev Button -->
        <button
            x-on:click="prev"
            class="text-6xl"
            :aria-disabled="atBeginning"
            :tabindex="atEnd ? -1 : 0"
            :class="{ 'opacity-50 cursor-not-allowed': atBeginning }"
        >
            <span aria-hidden="true">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 text-gray-800">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 19.5 8.25 12l7.5-7.5" />
                </svg>
            </span>
            <span class="sr-only">Skip to previous slide page</span>
        </button>

        <span id="carousel-content-label" class="sr-only" hidden>Carousel</span>

        <ul
            x-ref="slider"
            tabindex="0"
            role="listbox"
            aria-labelledby="carousel-content-label"
            class="flex w-full snap-x snap-mandatory overflow-x-scroll"
        >
            <li x-bind="disableNextAndPreviousButtons" class="flex w-1/3 shrink-0 snap-start flex-col items-center justify-center p-2" role="option">
                <div class="rounded-lg shadow-sm mt-2 w-full overflow-hidden aspect-square bg-gray-200">
                    <img class="w-full h-full" src="https://picsum.photos/400/400?random=1" alt="placeholder image">
                </div>

                <button x-bind="focusableWhenVisible" class="p-2 text-sm text-gray-800 font-medium">1</button>
            </li>

            <li x-bind="disableNextAndPreviousButtons" class="flex w-1/3 shrink-0 snap-start flex-col items-center justify-center p-2" role="option">
                <div class="rounded-lg shadow-sm mt-2 w-full overflow-hidden aspect-square bg-gray-200">
                    <img class="w-full h-full" src="https://picsum.photos/400/400?random=2" alt="placeholder image">
                </div>

                <button x-bind="focusableWhenVisible" class="p-2 text-sm text-gray-800 font-medium">2</button>
            </li>

            <li x-bind="disableNextAndPreviousButtons" class="flex w-1/3 shrink-0 snap-start flex-col items-center justify-center p-2" role="option">
                <div class="rounded-lg shadow-sm mt-2 w-full overflow-hidden aspect-square bg-gray-200">
                    <img class="w-full h-full" src="https://picsum.photos/400/400?random=3" alt="placeholder image">
                </div>

                <button x-bind="focusableWhenVisible" class="p-2 text-sm text-gray-800 font-medium">3</button>
            </li>

            <li x-bind="disableNextAndPreviousButtons" class="flex w-1/3 shrink-0 snap-start flex-col items-center justify-center p-2" role="option">
                <div class="rounded-lg shadow-sm mt-2 w-full overflow-hidden aspect-square bg-gray-200">
                    <img class="w-full h-full" src="https://picsum.photos/400/400?random=4" alt="placeholder image">
                </div>

                <button x-bind="focusableWhenVisible" class="p-2 text-sm text-gray-800 font-medium">4</button>
            </li>

            <li x-bind="disableNextAndPreviousButtons" class="flex w-1/3 shrink-0 snap-start flex-col items-center justify-center p-2" role="option">
                <div class="rounded-lg shadow-sm mt-2 w-full overflow-hidden aspect-square bg-gray-200">
                    <img class="w-full h-full" src="https://picsum.photos/400/400?random=5" alt="placeholder image">
                </div>

                <button x-bind="focusableWhenVisible" class="p-2 text-sm text-gray-800 font-medium">5</button>
            </li>

            <li x-bind="disableNextAndPreviousButtons" class="flex w-1/3 shrink-0 snap-start flex-col items-center justify-center p-2" role="option">
                <div class="rounded-lg shadow-sm mt-2 w-full overflow-hidden aspect-square bg-gray-200">
                    <img class="w-full h-full" src="https://picsum.photos/400/400?random=6" alt="placeholder image">
                </div>

                <button x-bind="focusableWhenVisible" class="p-2 text-sm text-gray-800 font-medium">6</button>
            </li>
        </ul>

        <!-- Next Button -->
        <button
            x-on:click="next"
            class="text-6xl"
            :aria-disabled="atEnd"
            :tabindex="atEnd ? -1 : 0"
            :class="{ 'opacity-50 cursor-not-allowed': atEnd }"
        >
            <span aria-hidden="true">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6 text-gray-800">
                    <path stroke-linecap="round" stroke-linejoin="round" d="m8.25 4.5 7.5 7.5-7.5 7.5" />
                </svg>
            </span>
            <span class="sr-only">Skip to next slide page</span>
        </button>
    </div>
</div>