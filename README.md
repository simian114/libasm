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
 고작 이 세줄이 끝인데? 대체 이 코드 어디에서 sys_read의 인자로 들어가는 rdi, rsi, rdx를 지정해준거지?  
 이에 대한 해답에 앞서서 우선 우리는 c로 만들어진 main문에서 ft_read를 함수로써 사용한다는 것을 인지해야한다.  
 즉, 아래와 같다.
``` 
  int main()  
  {  
      
      char buf[10];  
      ft_read(0, buf, 10);  
  }  
```
위의 코드를 보면 ft_read의 인자로 3개의 값을 전달해 준다. 이 인자들은 차례대로 rdi, rsi, rdx의 레지스터로 전달된다.  
이 내용은 calling convention을 확인하면 된다. convention에 따르면 함수로 들어간 인자는 차례대로 rdi,rsi, rdx, r10, r8, r9  
레지스터로 전달된다고 한다. 결과적으로 우리가 구현한 ft_read는 아래처럼 작동한다.
```
  rdi = 0, rsi = buf, rdx = 10
  sys_read(0, buf, 10)
```

