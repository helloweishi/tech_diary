title: virtual machine introspection
link: http://libvmi.com/
tag: vm
status: continuing

summary:
LibVMI is a C library with Python bindings that makes it easy to 
monitor the low-level details of a running virtual machine by viewing 
its memory, trapping on hardware events, and accessing the vCPU registers. 
This is called virtual machine introspection
