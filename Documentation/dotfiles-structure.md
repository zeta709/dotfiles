설정 파일 구조
==============

## `$HOME` 디렉토리의 설정 파일과 `.dotfiles`와의 관계

이 절에서는 `.vimrc`를 예로 들어 설명하지만, 다른 설정 파일에도 비슷한 논리가
적용될 수 있다.
이 repository의 `install.sh`는 `~/.vimrc`에
`source ~/.dotfiles/vim/dot.vim`을 추가하는 방법을 사용한다
([59b8c56](https://github.com/zeta709/dotfiles/commit/59b8c56a26602abddf38b6d4fcf06bb616073944)).
대안으로 다음 방법들을 생각할 수 있다.

* 대안 1: `.dotfiles/.vimrc`를 `~/.vimrc`로 복사
  * 단점: 변경 사항을 repository에 반영하려면
  `~/.vimrc`의 수정 사항을 직접 `.dotfiles/.vimrc`로 복사해야 한다.
  반대로 repository를 업데이트한 경우에도 변경 사항을 직접 복사해야 한다.
  즉, 설정 파일들을 동기화하기 어렵다.
* 대안 2: `.dotfiles/.vimrc`를 `~/.vimrc`가 가리키도록 심볼릭 링크로 연결
  * 단점: repository의 `.dotfiles/.vimrc`는 수정하지 않고
  `~/.vimrc`만 수정하는 것이 어렵다. Repository의 `.vimrc`가 모든 컴퓨터에서
  사용하는 설정을 포함하고 특정 컴퓨터에서만 사용하는 설정은 포함하지
  않게 만드는 것이 어렵다.
* 대안 3: 심볼릭 링크를 사용하면서,
  `.dotfiles/.vimrc`에 `source ~/.vimrc.local`를 추가한다.
  * 단점: `~/.vimrc.local`이라는 파일 이름을 기억해야 하며,
    `$HOME` 디렉토리에 파일의 수가 많아진다.

여기서 선택한 방법을 사용할 경우 반대로 변경 사항을 repositry에 반영하고
싶으면 `~/.vimrc`를 변경하지 않고, repository 내의 파일을 변경해야
한다는 것을 신경써야 한다. 이런 점에서는 방안 3과 큰 차이가 없으나,
`$HOME` 디렉토리에 파일 수를 줄일 수 있다는 점에서 현재 방법을 채택하였다.

## Vim의 plugin 관리

Vundle, VimPlug 등은 플러그인 관리를 도와주는 유용한 기능이다.
그런데 사소한 단점 중 하나는 `plug#begin()`으로 시작해서
`plug#end()`로 끝나는 plugin section이 하나만 존재해야 한다는 것이다.
그래서 플러그인도 local에서만 사용하고 싶은
플러그인이 있다면 다음과 같은 방법을 사용해야 한다.
논외로, 다음 방법을 사용할 경우 `other-plugins.vim`에는 `plug#begin()`과
`plug#end()` 없이 `Plug`만 존재하게 되는데, 이것은 조금 이상해 보인다.

```
plug#begin()
source ~/other-plugins.vim
plug#end()
```

여기서 문제는 `plug#begin()`과 `plug#end()`를 어디에 넣을 것인가이다.
만약 `dot.vim`에 넣게되면 `other-plugins.vim`은 `~/.vimrc`가 아닌 다른
파일이 되어야 한다. 지금 사용하는 구조에서는 `~/.vimrc`가 `dot.vim`을
포함하기 때문이다. 그래서 이렇게 하면 `.vimrc`가 `dot.vim`을 포함하고,
이것이 다시 `other-plugins.vim`을 포함해야 하므로 구조가 복잡해진다.

또, 무심코 `.vimrc`를 열었는데 이 파일에는 `plug#begin`과 `plug#end`가
없는 것을 확인하고 plugin section을 추가할 가능성도 있는데,
이렇게 되면 plugin section이 중복으로 정의되는 문제가 있다.

이런 이유에서, `plug#begin`과 `plug#end`는 `.vimrc`에서
직접 확인할 수 있도록 만드는 것이 좋다고 생각했다.
그래서 최종적으로 `.vimrc`를 다음과 같은 모양으로 만들었다.

```
call plug#begin('~/.vim/plugged')
source ~/.dotfiles/vim/dot-plugins.vim
call plug#end()
source ~/.dotfiles/vim/dot.vim
```

## color scheme 파일 구조

기존에는 colorscheme을 변경할 때 grep, sed 등을 이용해서 설정 파일을
수정하는 방법을 사용했다. 그런데 이렇게 하니 스크립트가 너무 복잡해지는
문제가 있었다.

그래서 각 설정 파일에서는 무조건 `.colors` 파일을 읽어오게 설정하고,
이 파일을 colorscheme 파일과 심볼릭 링크로 연결하는 방법으로 변경했다.
만약 colorscheme을 설정하지 않을 경우에는 `/dev/null`로 연결하면 된다.
예를 들면, `~/.vimrc`에 `source .dotfiles/vim/.colors.vim`를 추가하고,
`.colors.vim`를 실제 설정 파일에 심볼릭 링크로 연결하는 것이다.
`/dev/null`을 source하는 것은 해가 없기 때문에 파일의 존재 유무를
확인할 필요가 없고, `.tmux.conf`의 경우처럼 파일의 존재 유무를
확인하고 선택적으로 source하기 어려운 경우에도 이 방법을 적용할 수 있다.
또한, colorscheme 파일 이름에 일관된 규칙을 적용하였다. 이렇게 하여
200줄이 넘는 `colorscheme.sh`를 120줄로 줄이면서도 colorscheme을 초기화하는
기능을 추가했다.
([93b4dcb](https://github.com/zeta709/dotfiles/commit/93b4dcbfaf4bb8fa289e8c5ca6d51c6f96099c7b),
[325b8b6](https://github.com/zeta709/dotfiles/commit/325b8b61df7c89fcf62feb6b25a2167bb9c92885),
[a0b9010](https://github.com/zeta709/dotfiles/commit/a0b9010d2dc754d0683ff7deed942c41a02de620))

## 여러 dotfiles repositories 사용

디렉토리 이름이 반드시 `.dotfiles`일 필요는 없기 떄문에 여러 dotfiles
repository를 사용하는 것도 문제 없다.
