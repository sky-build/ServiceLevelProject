# 친구 맺기 앱

## 앱 기능
가까이 있는 친구와 함께 취미를 공유할 수 있는 앱입니다. 회원가입과 로그인을 수행하고, 내가 함께 공유하고 싶은 취미를 등록하고, 나와 취미가 같은 주변 친구를 지도에서 확인하고 친구를 추가 할 수 있습니다. 친구를 맺은 후 채팅을 할 수 있고, 채팅이 끝난 후 친구에 대한 리뷰를 남길 수 있습니다.

## 개발 목표
- 중복되는 코드 제거(View, HTTP 통신)
- Enum 적극적으로 사용하기
- MVVM, RxSwift 적용하기

## 수행한 것

- **SnapKit**으로 **UI** 구현
- **FirebaseAuth**를 이용해 전화번호 인증
- **RxSwift** 와 **MVVM** 적용
- **Socket.IO**를 사용해 채팅 구현
- **MapView**, **CLLocationManager**를 이용해 지도 업데이트
- 중복되는 **View 재사용**

## 배운 것

- View를 재사용하기위해 코드를 구조화하는것이 중요하다.
- **UICollectionView**를 **Paging**하는법을 알게되었다.
- Commit 컨벤션을 지키면 깃허브에서 변경사항을 확인하는 데 도움이 된다.
- 로그인하는 디바이스가 바뀔 때 **FCMToken**을 업데이트 해야한다.
- **RxSwift**에 대한 이해

## Issue
- 중복되는 View 재사용
- FirebaseAuth를 사용해 전화번호 인증
- MapView, CLLocationManager 사용해 지도 업데이트
- SocketIO 사용해 채팅 구현
- RxSwift, MVVM 적용
- SnapKit으로 UI 구현
- View 관련 프로토콜 사용
    ``` Swift
    protocol FetchViews {
        func addViews()
        func makeConstraints()
    }
    ```
- ViewController에 중복적으로 사용되는 코드를 BaseViewController에 코드를 작성하고 상속