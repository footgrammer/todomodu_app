# 🐝 투두모두 - 협업 중심 투두 & 일정 관리 앱

> 개인 또는 팀 단위 프로젝트에서 역할 분담, 일정 정리, 공지/알림 관리를 간편하게 할 수 있는 생산성 앱입니다.  
> 특히 \*\*사용자별 우선순위 기반 # 🐝 투두모두 - 협업 중심 투두 & 일정 관리 앱

> 개인 또는 팀 단위 프로젝트에서 역할 분담, 일정 정리, 공지/알림 관리를 간편하게 할 수 있는 생산성 앱입니다.  
> 특히 **사용자별 우선순위 기반 투두 정렬**과 **GPT 기반 자동 투두 생성**, **할 일 공유 기능**이 핵심입니다.

---

## 📁 데이터베이스 구조 (Firebase Firestore 기준)

### 1. users/{userId}

- 사용자 인증 정보 및 프로필용 문서

### 2. users/{userId}/todo_priorities/{todoId}

- 사용자 개인 기준의 `Todo` 우선순위 관리
- 각 사용자가 같은 Todo에 대해 **서로 다른 우선순위**를 가질 수 있음

```json
{
  "priority": 100,
  "pinned": false,
  "createdAt": Timestamp,
  "updatedAt": Timestamp
}
```

- ⚠️ `todo_priorities`는 **실시간 정렬, 드래그 이동**에 사용되므로 반드시 **서브컬렉션으로 분리**해야 함

---

### 3. todos/{todoId}

- 프로젝트별 할 일(Todo) 단위

```json
{
  "projectId": "project123",
  "title": "기획안 작성",
  "startDate": Timestamp,
  "endDate": Timestamp,
  "isDone": false,
  "priority": 1000
}
```

---

### 4. todos/{todoId}/subtasks/{subTaskId}

- Todo 안의 세부 작업 단위
- 각 SubTask에는 담당자(`assignee`)가 지정될 수 있음

```json
{
  "title": "조사 정리",
  "isDone": false,
  "assignee": "user456"
}
```

---

### 5. user_settings/{userId}

- 사용자 맞춤 설정 (UI/환경 관련)

```json
{
  "projectColors": {
    "projectA": "#A0E8AF",
    "projectB": "#FFD4C3"
  },
  "darkMode": true,
  "language": "ko"
}
```

---

## 🔄 사용자 우선순위 동기화 로직

- SubTask 담당자가 지정될 때: `/users/{userId}/todo_priorities/{todoId}` 문서 자동 추가
- 기본 priority는 가장 마지막 값 기준 `+100`
- SubTask가 모두 제거되면 todo_priorities에서 삭제 (선택)

---

## 🖱️ Drag & Drop 정렬 처리

- 순서 변경 시 priority 재계산: `(A.priority + B.priority) / 2`
- 우선순위는 간격 기반 (`1000`, `1100`, `1200`, ...)

---

## 🔎 쿼리 예시

```dart
FirebaseFirestore.instance
  .collection('users')
  .doc(currentUserId)
  .collection('todo_priorities')
  .orderBy('priority')
```

---

## ✨ 확장 가능성

- `todo_priorities`: `isArchived`, `lastViewedAt` 등 추가 가능
- `user_settings`: 알림, 언어 설정 추가
- GPT API 연동 자동 투두 생성

---

## 📌 정리

| 기능                      | 위치                              | 설명                      |
| ------------------------- | --------------------------------- | ------------------------- |
| 사용자별 우선순위         | `/users/{userId}/todo_priorities` | 정렬 로직 핵심            |
| 프로젝트별 색상 설정      | `/user_settings/{userId}`         | UI 맞춤 설정              |
| 실시간 드래그 반영        | Firestore priority 필드           | float 또는 gap 방식       |
| 사용자에게 Todo 자동 등록 | SubTask 할당 시                   | 우선순위 컬렉션 자동 추가 |

---

> 함께 일할수록 가벼워지는 할 일,  
> 투두모두와 함께 시작하세요. ☀️투두 정렬**과 **GPT 기반 자동 투두 생성**, **할 일 공유 기능\*\*이 핵심입니다.

---

## 📁 데이터베이스 구조 (Firebase Firestore 기준)

### 1. users/{userId}

- 사용자 인증 정보 및 프로필용 문서

### 2. users/{userId}/todo_priorities/{todoId}

- 사용자 개인 기준의 `Todo` 우선순위 관리
- 각 사용자가 같은 Todo에 대해 **서로 다른 우선순위**를 가질 수 있음

```json
{
  "priority": 100,
  "pinned": false,
  "createdAt": Timestamp,
  "updatedAt": Timestamp
}
```

- ⚠️ `todo_priorities`는 **실시간 정렬, 드래그 이동**에 사용되므로 반드시 **서브컬렉션으로 분리**해야 함

---

### 3. todos/{todoId}

- 프로젝트별 할 일(Todo) 단위

```json
{
  "projectId": "project123",
  "title": "기획안 작성",
  "startDate": Timestamp,
  "endDate": Timestamp,
  "isDone": false,
  "priority": 1000
}
```

---

### 4. todos/{todoId}/subtasks/{subTaskId}

- Todo 안의 세부 작업 단위
- 각 SubTask에는 담당자(`assignee`)가 지정될 수 있음

```json
{
  "title": "조사 정리",
  "isDone": false,
  "assignee": "user456"
}
```

---

### 5. user_settings/{userId}

- 사용자 맞춤 설정 (UI/환경 관련)

```json
{
  "projectColors": {
    "projectA": "#A0E8AF",
    "projectB": "#FFD4C3"
  },
  "darkMode": true,
  "language": "ko"
}
```

---

## 🔄 사용자 우선순위 동기화 로직

- SubTask 담당자가 지정될 때: `/users/{userId}/todo_priorities/{todoId}` 문서 자동 추가
- 기본 priority는 가장 마지막 값 기준 `+100`
- SubTask가 모두 제거되면 todo_priorities에서 삭제 (선택)

---

## 🖱️ Drag & Drop 정렬 처리

- 순서 변경 시 priority 재계산: `(A.priority + B.priority) / 2`
- 우선순위는 간격 기반 (`1000`, `1100`, `1200`, ...)

---

## 🔎 쿼리 예시

```dart
FirebaseFirestore.instance
  .collection('users')
  .doc(currentUserId)
  .collection('todo_priorities')
  .orderBy('priority')
```

---

## ✨ 확장 가능성

- `todo_priorities`: `isArchived`, `lastViewedAt` 등 추가 가능
- `user_settings`: 알림, 언어 설정 추가
- GPT API 연동 자동 투두 생성

---

## 📌 정리

| 기능                      | 위치                              | 설명                      |
| ------------------------- | --------------------------------- | ------------------------- |
| 사용자별 우선순위         | `/users/{userId}/todo_priorities` | 정렬 로직 핵심            |
| 프로젝트별 색상 설정      | `/user_settings/{userId}`         | UI 맞춤 설정              |
| 실시간 드래그 반영        | Firestore priority 필드           | float 또는 gap 방식       |
| 사용자에게 Todo 자동 등록 | SubTask 할당 시                   | 우선순위 컬렉션 자동 추가 |

---

> 함께 일할수록 가벼워지는 할 일,  
> 투두모두와 함께 시작하세요. ☀️
