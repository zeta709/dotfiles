### Windows subsystem for Linux

It works!

### MinGW

> **Note**
>
> This section is outdated.

MinGW 환경에서는 거의 비슷하게 동작하며, 필요에 따라 mintty 설정만 추가하면 된다.

### Native Windows

> **Note**
>
> This section is outdated.

순수 Windows 환경에서는 git, vim 설정만 사용할 수 있다. 윈도우용 batch 파일도
작성했지만 몇가지 문제가 있다.
특히 `intall.bat`은 줄바꿈 문자를 무조건 윈도우 형식으로 넣기 때문에
`_vimrc`의 줄바꿈 문자를 미리 윈도우 형식으로 변경해 두어야 하며,
`_vimrc`의 줄바꿈 문자가 유닉스 형식인 상태에서 `install.bat`을 실행하면
`_vimrc`를 망가뜨리게 된다.
그리고 `install.bat`을 중복으로 실행해도 `_vimrc`를 망가뜨리게 된다.
