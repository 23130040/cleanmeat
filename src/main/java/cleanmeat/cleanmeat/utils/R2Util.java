package cleanmeat.cleanmeat.utils;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import java.io.InputStream;
import java.net.URI;

public class R2Util {
    private final String bucketName = "cleanmeat";

    private S3Client s3Client() {
        AwsBasicCredentials credentails = AwsBasicCredentials.create(
                "0c8a93e46371fa9278d3871c233ac13b",
                "c1a1072381e6cb30e151d6925ba4f06818c005d8d2e581df1057eb02755e15a5"
        );
        return S3Client.builder()
                .endpointOverride(URI.create("https://163f8b638fa8ffd40fdd9ebbfeadb434.r2.cloudflarestorage.com"))
                .credentialsProvider(StaticCredentialsProvider.create(credentails))
                .region(Region.US_EAST_1)
                .build();
    }

    public String uploadFile(String fileName, InputStream inputStream, long length, String contentType) {
        PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                .bucket(bucketName)
                .key(fileName)
                .contentType(contentType)
                .build();

        s3Client().putObject(putObjectRequest, software.amazon.awssdk.core.sync.RequestBody.fromInputStream(inputStream, length));
        return "https://pub-71ec9cf4f0b64801a2907204d81a0b26.r2.dev/" + fileName;
    }
}
