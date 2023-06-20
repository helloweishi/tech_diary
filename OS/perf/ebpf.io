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

