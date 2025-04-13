# 客製化輸入框元件
此元件基於原生 `UITextField`產生，具有以下功能：
1. 支援標題顯示：清楚提示欄位輸入目的。
2. 動態邊框顏色：輸入時動態變更邊框顏色，提升欄位辨識度。
3. 錯誤訊息提示：驗證失敗時顯示錯誤訊息，協助使用者即時修正。
4. 自訂右側功能：可自訂是否顯示清除按鈕（Clear Button）或右側按鈕（Right View）。

![樣式](/Users/jru/Desktop/BorderTextFieldWithError/README IMAGE/預設.png)


## 使用方式（Usage）
**使用 Storyboard / Xib**

```Swift
  @IBOutlet weak var textField: BorderTextFieldWithErrorMsg!
```
**使用 Auto Layout 動態建立元件**

建立元件
``` Swift
  lazy private var textField: BorderTextFieldWithErrorMsg = {
      let textField = BorderTextFieldWithErrorMsg()
      textField.setTitleInfo(titleText: "標題名稱")
      textField.placeholder = "預設文字"
      self.view.addSubview(textField)
      return textField
  }()
```

設定元件位置
```Swift
  NSLayoutConstraint.activate([
    textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
    textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
    textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
  ])
```

## 標題（Title）
* 顯示標題
```Swift
 textField.setTitleInfo(titleText: "標題名稱")
```
* 隱藏標題（傳入空字串或 nil）

  可以給`空字串`或`nil`
```Swift
 textField.setTitleInfo(titleText: "")
```

## 預設文字（Placeholder）

可透過程式碼設定，或在 Interface Builder 的 Attributes inspector 中設定
```Swift
 textField.placeholder = "預設文字"
```

## 清除按鈕（Clear Button）
![清除按鈕](/Users/jru/Desktop/BorderTextFieldWithError/README IMAGE/清除按鈕.png)

輸入文字時，右側出現清除文字按鈕
```Swift
textField.clearButtonMode = .whileEditing
```

## 右側按鈕（RightView)
![右側按鈕](/Users/jru/Desktop/BorderTextFieldWithError/README IMAGE/右側功能.png)

可加上自訂按鈕或圖示
```Swift
textField.rightView = UIView()
```

## 錯誤訊息（ErrorInfo)
![錯誤訊息](/Users/jru/Desktop/BorderTextFieldWithError/README IMAGE/錯誤訊息.png)

* 顯示錯誤訊息
```Swift
textField.setErrorInfo(errorText: "錯誤訊息")
```
* 隱藏錯誤訊息（傳入空字串或 nil）

  可以給`空字串`或`nil`
```Swift
 textField.setTitleInfo(titleText: "")
```

## 邊框顏色設定

- `borderColor`： 尚未點擊的邊框的顏色
- `inputBorderColor`： 輸入中的邊框顏色
```Swift
textField.setBorderColor(borderColor: UIColor.purple, inputBorderColor: UIColor.purple)
```
