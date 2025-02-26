import RPi.GPIO as GPIO
import time

def setup_sensor():
    # Use BCM pin numbering
    GPIO.setmode(GPIO.BCM)

    pin = int(input("Enter the GPIO pin for the wet sensor (15 default): "))
    # Set up the pin as input (no internal pull-up/down resistor)
    GPIO.setup(pin, GPIO.IN)

    return pin

def check_sensor(pin):
    # Read the sensor state: HIGH means wet (moisture detected), LOW means dry
    if GPIO.input(pin) == GPIO.HIGH:
        print("!!! MOISTURE DETECTED, REMOVE ROV FROM WATER IMMEADIATELY !!!")
        return True
    else:
        print("No moisture detected")
        return False

def test():
    pin = setup_sensor()
    try:
        # Call check_sensor() every second
        while True:
            check_sensor(pin)
            time.sleep(1)
    except KeyboardInterrupt:
        print("Exiting program.")
    finally:
        GPIO.cleanup()

if __name__ == "__main__":
    test()
