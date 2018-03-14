zsh 설정
========

설정 파일을 간결하게 유지하고 로딩 시간을 줄이는 것을 목표로 삼았다.
처음에는 oh-my-zsh 설정을 사용하였으나, 성능 문제가 있었고
불필요한 설정도 있었기 때문에 완전히 제거하였다.

## completion

### matcher-list

matcher-list의 가장 처음 항목으로 `''`이 있는 것은 perfect match를
가장 우선적으로 선택하게 만들기 위함이다. 이것이 없으면 원하지 않는 동작을
보이는 경우가 있다.

대소문자가 섞인 파일이 복잡하게 있는 경우에 대응하기 위해
`'m:{a-zA-Z-_}={A-Za-z_-}'`도 3단계로 분리하였다.

## history

History로 무엇을 했는지 정확히 알기 위해 `hist_ignore_all_dups` 옵션은
사용하지 않았다. 사소한 `ls` 명령은 무시하도록 했지만 복잡한 `ls` 명령은
기록하도록 했다.

## prompting

PS1에 함수를 넣으면 프롬프트를 출력할때마다 함수가 실행된다.
특히, 터미널 크기를 바꾸기만해도 함수가 실행된다.
그러므로 git 상태 확인 처럼 오래 걸리는 함수를
PS1에 넣는 것은 좋지 않으며, precmd에 함수를 넣고 환경 변수를 설정하는
방법을 사용하는 것이 좋다.

### git 상태 확인

Git 브랜치를 확인하는 것도 가벼운 작업은 아니다. 현재 directory와 timestamp를
기록하여 git branch 정보를 재사용할 수 있도록 하였다.
특히, git dirty를 확인하는 것은 시간이 매우 오래 걸리기 때문에
이 기능은 넣지 않았다.

### PS1 줄바꿈

PS1의 길이가 화면의 절반을 넘어가는 경우에만 줄바꿈을 하도록 했다.

## References

* <http://zsh.sourceforge.net/Doc/>
* <http://zsh.sourceforge.net/Guide/>
* <http://zshwiki.org>
* <https://wiki.archlinux.org/index.php/zsh>
* <https://wiki.gentoo.org/wiki/Zsh/Guide>
* <https://github.com/robbyrussell/oh-my-zsh>
* <https://anonscm.debian.org/cgit/collab-maint/zsh.git>
