# LIBASM
-----

### 1. How to compile?
```
  Linux
    - nasm -f elf64 file.s -o file.o
  Mac
    - nasm -f macho64 file.s -o file.o
  
  이후의 라이브러리로 만드는 작업은 libft와 동일
```
-----
### 2. ft_read

ft_read를 구현하기 위해서 위해서는 시스템콜을 직접 호출해야한다.  
호출하는 방법은 rax 레지스터에 sys_read의 번호를 넣고 syscall을 호출해야한다.  
생각해보면 read 함수는 read(int fd, void \*buf, size_t count)의 형태고 이런 인자들이 들어가야 하는데 
위에서 처럼 rax 레지스터에 sys_read의 번호만 넣고 호출하면 인자는 어떻게 넘겨주는걸까?
(https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64) 이 주소를 확인해보면
sys_read의 인자로 rdi, rsi, rdx로 들어가는 걸 확인할 수 있다.
즉, syscall 을 호출하기 전에 먼저 rdi, rsi, rdx에 fd, buf, count를 지정해야한다.
하지만 내 코드를 보면
```
    mov rax, 0  
    syscall  
    ret  
```  
 고작 이 세줄이 끝인데? 대체 어디서 인자를 정해준거지?
 하나 또 생각해 볼게 나는 이 ft_read를 하나의 함수로 만들어서 c로 만들어진 main 문에서 사용한다는거다.
 즉, 아래와 같이 사용하는거다.
``` 
  int main()  
  {  
      
      char buf[10];  
      ft_read(0, buf, 10);  
  }  
```
여기서 calling convention 이라는 것을 확인해야하는데, calling convention에 따르면 함수의 인자로 들어온 값들은
순서대로 rdi, rsi, rdx, r10, r8, r9 레지스터에 담기게 된다.
따라서 ft_read(0, buf, 10)을 호출하면 내가 구현한
  
  mov rax, 0
  syscall
  ret
