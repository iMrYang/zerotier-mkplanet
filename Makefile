mkplanet:
    c++ -o $@ -std=c++11 -I. -Inode *.cpp -Iosdep -lm

clean:
    rm -f mkplanet
