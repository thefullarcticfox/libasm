# libasm
42 libasm project in Intel x86 syntax

### Running on Linux
1. Install nasm
2. Run `make` to build or ```make runtest``` to build and run test

### Porting to Linux
1. Change ```-fmacho64``` to ```-felf64``` in ```NAFLAGS``` in Makefile
2. Add `-no-pie` to `CFLAGS` in Makefile **OR** add `WRT ..plt` to every glibc function call
> The call instructions into glibc themselves require extra ELF setting to make the linking dynamic ("abusing" a bit directive `WRT` "with regard" and special keyword `..plt`) // [Stackexchange thread](https://codereview.stackexchange.com/a/181964)
3. Change ```mov``` instuctions before ```syscall``` in ```ft_read.s``` and ```ft_write.s``` to 0 and 1 instead of 0x02000003 abd 0x02000004
4. Remove all preceding underscores in all function names (so ```_ft_read``` becomes ```ft_read```)
5. Change ```___error``` to ```__errno_location``` in ```ft_read.s``` and ```ft_write.s```
6. Linux syscalls return negative errno value on error so you need to change error condition check and errno assignment
