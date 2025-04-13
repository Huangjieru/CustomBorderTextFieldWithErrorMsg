# 客製化輸入框元件
此元件基於原生 `UITextField`產生，具有以下功能：
1. 支援標題顯示，清楚提示欄位輸入目的。
2. 輸入時動態變更邊框顏色，提升欄位辨識度。
3. 驗證失敗時顯示錯誤訊息，協助使用者即時修正。
4. 可自訂是否顯示清除按鈕或右側按鈕功能。

## Usage
* **Storyborad, Xib**

```Swift
@IBOutlet weak var textField: BorderTextFieldWithErrorMsg!
```
* **AutoLayout**
``` Swift
let textField = BorderTextFieldWithErrorMsg()
self.view.addSubview(textField)

NSLayoutConstraint.activate([
    textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
    textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
    textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
])
```

## Title
* **有標題**
```Swift
 textField.setTitleInfo(titleText: "標題名稱")
```
* **沒有標題**

  可以給`空字串`或`nil`
```Swift
 textField.setTitleInfo(titleText: "")
```

## Placeholder

可以用程式碼撰寫或在 storyboard 的 Attributes inspector 的 Placeholder 欄位填寫
```Swift
 textField.placeholder = "預設文字"
```

## Clear Button

輸入文字時右側會出現清除按鈕
```Swift
textField.clearButtonMode = .whileEditing
```

## RightView

右側功能按鈕或圖片
```Swift
textField.rightView = UIView()
```

## 邊框顏色

參數 borderColor 尚未點擊輸入框的顏色；inputBorderColor是正在輸入時輸入框的顏色
```Swift
textField.setBorderColor(borderColor: UIColor.purple, inputBorderColor: UIColor.purple)
```
