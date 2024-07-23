# AWS cliでS3バケットにファイルアップロード方法

# ■前提条件：
- aws configure既に設定されていること
- s3アクセス権限が付与されていること
- バケット作成されていること

---
### 手順
## ■ option 1(high level)
- ローカルからファイルをコピーする
  ```
 $ aws s3 cp --profile ＜ユーザ名＞ ＜コピー元のファイル名＞ s3://＜バケット名＞
  ```
## ■ option 2(low level) multipart upload
- splitで大容量ファイルを分割する
- MacOSの場合は、以下のコマンドでファイルを分割する
  ```
　$ split -b XXm ＜ファイル名＞
  ```
- ファイルを分割した後、lsコマンドでファイル名を特定する
  ```
  $ ls 
  ```
- アップロード ID を作成する
  ```
  $ aws s3api --profile ＜ユーザ名＞ create-multipart-upload --bucket ＜バケット名＞ --key ＜ファイル名＞
  ```
- 分割した後、s3に各ファイルをアップロードする
  ```
  $ aws s3api --profile ＜ユーザ名＞ upload-part --bucket ＜バケット名＞ --key ＜ファイル名＞ --part-number ＜パート番号＞ --body ＜分割後の各ファイル名＞ --upload-id ＜アップロードID＞
  ```
- アップロード後にパートをリストする
  ```
  $ aws s3api --profile ＜ユーザ名＞ list-parts --bucket ＜バケット名＞ --key ＜ファイル名＞ --upload-id ＜アップロードID＞
  
  None s3タイプ
  INITIATOR IAMユーザ、ID
  OWNER 名、ID
  PART ID、日付、パート番号
  ```
- 分割したファイルをマージするため、パラメータファイルを作成する。（ファイル名任意）
  ```
	{
		"Parts": [{
				"ETag": "0f1c156afcd94808ffd6f4f383962d09",
				"PartNumber":1
			},
			...
			{
				"ETag": "0f1c156afcd94808ffd6f4f383962d09",
				"PartNumber":3
			}]
	}
   ```
- 上記のパラメータファイルを指定し、ファイルをマージする
  ```
  $ aws s3api --profile anhthu complete-multipart-upload --multipart-upload file://filepart.json --bucket uploadfile-123 --key cloud.mov --upload-id geoEjHVhjvztF_J3Dr8rKpbGov9RaMnXnFOp9IywoKM.dJiSdSwuzuCIejRtIPiJke30h_90_LcQHaQytQa_Sl3wJzGT89bRxAf_p.qk0NQ27wJ31PfAiJSAVlzmmbGQk50IF7cHL1K.AulD_KOYLw--
  ```
- s3バケットを確認し、ファイルがアップロードできることを確認すること


