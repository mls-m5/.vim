Vim configuration
=================


Dependencies
------------

Install clang

For more information visit
https://apt.llvm.org/

// Here example with clang 13, feel free to use any later (or earlier version)

```sh
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
sudo apt install clang-format-13
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-13 100
```

