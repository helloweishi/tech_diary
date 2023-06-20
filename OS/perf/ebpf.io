title: ebpf.io
link: https://ebpf.io/
tag: ebpf
status: none
summary:
https://github.com/harporoeder/ebpfsnitch :firewall

notes:
ISA version selection during compile:
  $ llc probe.bc -mcpu=v2 -march=bpf -filetype=obj -o probe.o
  With clang one can use -mllvm -mcpu=v2 to do the same.
  v3 is the latest one

Bloom filter + map : enhance performance
  bpf_map_create(BPF_MAP_TYPE_BLOOM_FILTER, NULL, 0, sizeof(value), 100, NULL);

Task local storage: to the owning task for performance boost accessing
  ptr = bpf_task_storage_get(&start, t, 0, BPF_LOCAL_STORAGE_GET_F_CREATE);

program pack allocator: pack programs together on a page when allocating them
  bpf_prog_allocator 

code inlining not always the best choice: it eliminates a call, but increases the code size using instruction cache less efficiently
  option to decide inline or not inline on modern versions of kernel

EBPF performance tracking: 
Talking to the compiler
   clang can generate an Optimization Report when compiling a program
   $ clang -O2 -Rpass=.* -Rpass-analysis=.* -Rpass-missed=.*

collects BPF execution counters:
  $ sysctl -w kernel.bpf_stats_enabled=1
  counters could be read via bpftool:
  $ bpftool prog
    379: raw_tracepoint [...] run_time_ns 35875602162 run_cnt 160512637

  use memory events with perf
    $ cat /proc/kallsyms | grep bpf_prog
    [...]
    ffffffffc0201990 t bpf_prog_31e86e7ee100ebfd_test [bpf]
    $ perf trace -e mem:0xffffffffc0201990:x
    [ trigger the BPF program in another session ]
    18446744073790.551 ls/242 mem:0xffffffffc0201990:x()

ebpf debug log
  bpf_trace_printk("Timestamp: %lld", ts);
  fetch from either a trace_pipe, or using bpftool:
  $ cat /sys/kernel/debug/tracing/trace_pipe
  $ bpftool prog tracelog
  it will slow program down
  more efficient: introduce the map to buffer data on the kernel side, read this map

