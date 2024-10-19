# ------------------------------------------------------------------
# Example: pynq Interrupt handler
# ------------------------------------------------------------------
from pynq import Overlay, Interrupt, GPIO
from pynq.lib import AxiGPIO
import asyncio
from pynq import DefaultIP

# ------------------------------------------------------------------
# ISR
# ------------------------------------------------------------------
async def handle(btn, leds, btn_gpio):
    while True:
        print("Waiting for interrupt")
        await btn.wait_for_interrupt_async()
        print("Interrupt captured!")
        leds[0:3].toggle()
        print("LED toggled")

# ------------------------------------------------------------------
# Main function
# ------------------------------------------------------------------
async def main():
    print("Loading overlay...")
    base = Overlay("top_module.xsa")
    print("Setting up GPIO objects")
    btn_gpio = baee.ip_dict['btn_gpio']
    led_gpio = baee.ip_dict['led_gpio']
    leds = AxiGPIO(led_gpio).channel1
    btn = AxiGPIO(btn_gpio).channel1
    print("Reset LEDs")
    leds[0:3].off()

    # Start the interrupt handler as a background task
    handler_task = asyncio.create_task(handle(btn,leds,base.btn_gpio))

    count = 0
    while True:
        await asyncio.sleep(5) # async sleep for 5 seconds
        print(count)
        count += 1

    if __name__ == "__main__":
        asyncio.run(main())
