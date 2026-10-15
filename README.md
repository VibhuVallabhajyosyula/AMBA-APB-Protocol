# AMBA-APB-Protocol
This project implements the Advanced Peripheral Bus (APB) protocol, part of Arm's AMBA on-chip communication architecture. APB is designed for low-bandwidth, low-complexity peripherals such as UARTs, GPIOs, and timers.

The design uses a finite state machine (FSM) with three states: IDLE, SETUP, and ACCESS. It supports memory-mapped read and write transactions, address decoding, and transfer completion through the PREADY signal.
