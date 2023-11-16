# README

* Ruby version ruby-3.2.2

### System dependencies
- ImageMagick - `brew install imagemagick`

### Database & Storage
- SQLite
- Local file storage

### How to run the test suite
- `cd pockethealth` and then `bin/rails test .`

### Deployment instructions
- install rails on your machine
- `brew install imagemagick` if not previously done
- `cd pockethealth` and then `bundle install`
- `bin/rails s` to start the server

### API endpoints
- `GET /dicom_files` shows all uploaded dicom file records
- `POST /dicom_files` creates/uploads a dicom file and returns queried tag
    - Query Params : `tag`
    - form-data :
        - dicom_file[dicom_image] type:File
        - dicom_file[name] type:Text

### Sample Request/Response

#### Request:
```
{{host}}/dicom_files?tag=0010,0030

form-data:
dicom_file[dicom_image]=<AttachedFile>
dicom_file[name]="XRay Scan 1"
```

#### Response:
```
{
    "name": "XRay Scan 1",
    "dicom_image_url": "http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6NDM4LCJwdXIiOiJibG9iX2lkIn19--991056bcb0bbb71a3231fa6dbfd56ccd5529db2f/IM000014",
    "browser_viewable_image_url": "http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6NDM5LCJwdXIiOiJibG9iX2lkIn19--0218342c72161112f7e72afb4aee7853ddb0d0d2/1700113525.png",
    "tag": "0010,0030",
    "tag_value": "19880314"
}
```

### Test Suite Run
```
Running 12 tests in a single process (parallelization threshold is 50)
Run options: --seed 59910

# Running:

............

Finished in 1.047347s, 11.4575 runs/s, 22.9150 assertions/s.
12 runs, 24 assertions, 0 failures, 0 errors, 0 skips
```
