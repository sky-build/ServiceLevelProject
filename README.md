# 친구 맺기 앱

## 앱 기능
가까이 있는 친구와 함께 취미를 공유할 수 있는 앱입니다. 회원가입과 로그인을 수행하고, 내가 함께 공유하고 싶은 취미를 등록하고, 나와 취미가 같은 주변 친구를 지도에서 확인하고 친구를 추가 할 수 있습니다. 친구를 맺은 후 채팅을 할 수 있습니다.

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

## 구현 화면

### Onboarding 화면
|1|2|3|
|-|-|-|
|<img src="https://user-images.githubusercontent.com/26789278/163788366-2d66837e-2544-4a7e-a7b0-3927359a9c9d.png"  width="200" height="410">|<img src="https://user-images.githubusercontent.com/26789278/163788379-6795eaec-93bd-4427-aaed-f8e5a8083ae4.png"  width="200" height="410">|<img src="https://user-images.githubusercontent.com/26789278/163788387-5a08df8c-1954-466d-bda3-c57d5cd28ae5.png"  width="200" height="410">|


### 회원가입
|전화번호 입력|전화번호 인증|닉네임 입력|이메일 입력|성별 입력|
|---------|----------|---------|--------|------|
|<img src="https://user-images.githubusercontent.com/26789278/163787325-b671f72a-d983-4849-8b7e-ff9b6c76e893.png"  width="200" height="410">|<img src="https://user-images.githubusercontent.com/26789278/163787333-12982d85-a1be-464f-9beb-d43ca5242957.png"  width="200" height="410">|<img src="https://user-images.githubusercontent.com/26789278/163787338-092ae01b-bd8a-4a8a-9ac2-0cf605b7c67e.png"  width="200" height="410">|<img src="https://user-images.githubusercontent.com/26789278/163787343-193956e5-f167-46a9-a3c3-f5be94f2d7fe.png"  width="200" height="410">|<img src="https://user-images.githubusercontent.com/26789278/163787351-12691215-ae66-4f14-b23e-1483b63bba59.png"  width="200" height="410">|

### 메인 화면
|홈 화면|취미 등록|주변 친구 목록|채팅|설정|
|-----|-------|-----------|--|---|
|<img src="https://user-images.githubusercontent.com/26789278/163789597-6208ffde-0b69-4924-b367-512620c005b9.png"  width="200" height="410">|<img src="https://user-images.githubusercontent.com/26789278/163789595-b07cf97d-468e-491e-a326-f6e5811f2c5f.png"  width="200" height="410">|<img src="https://user-images.githubusercontent.com/26789278/163789589-2fd17808-2164-42e4-92f3-619cdb3bf651.png"  width="200" height="410">|<img src="https://user-images.githubusercontent.com/26789278/163789572-78ce458a-1da6-449d-83f5-fa528b460264.png"  width="200" height="410">|<img src="https://user-images.githubusercontent.com/26789278/163790198-9ce89c8e-4839-4346-85d6-f85a8b2a93b5.png"  width="200" height="410">|

