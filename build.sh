
#remove outputs
rm -r output
mkdir output
mkdir output/nb-redis
mkdir output/nb-taskengine
mkdir output/nb-rabbitmq
mkdir output/nb-mongodb
mkdir output/nb-elasticsearch

#build images
echo "---------------build ./nb-redis---------------"
cd ./nb-redis
docker image build -t cg2-linux-asg/redis -f Dockerfile .
docker tag cg2-linux-asg/redis:latest 041444721655.dkr.ecr.us-east-1.amazonaws.com/cg2-linux-asg/redis:latest
docker login -u AWS -p eyJwYXlsb2FkIjoiaVRSQkNKODJRTXExcDhvVkZrdXVkNFlKWnFvTXpTcm54SDZqK1B6WjYzaDNDK3plVHF3ZXdFR1dDbTlBaktPdXVHU1FBanB2Q2Mwdzhub0g4SFp3QUErVEZkSTlPU05nN0F2YW5Hc2xydks5Y3piTStwblB5NmxoQzRENVlYWFZUR0NIWmNYaFVNMkV6b1pWWk5XaStwYXNJb0R6OGg1YkM5N2dVVVYwSUlXVUEvb3ArUEJmalk3bEtiQmhiSjJ2K1FsbVNaVGNtbldSSXF0QUVSdUhMUGxiOVBCZ2JuZHBvcVhBaDdZNnVnSFcvcW1JTEVqS0tneDBYYVo3ckEzV1IvY2RaM1B5TzBQWXBKK2JmV3psaEh2MVRWS3RZQjlsUkUwaXF4Zkw2Q1VDKzYwaUoxZjhwVzBHNHZWTUpQNVZLK3FBc1NxbGlNSkVUUzZJOFBlS1dqUzNLTVpkT1M0cURhOFBDMnBzNlRaWU9aVUFJUi9VNjVhUEFDNVk1Y0c0a09rbnJzend2NjhjN3p3dlFOUXV6eStaaU5LRjdwcmxGbFM4d0N3MjFYZmlkV1VlQlY1YlZUcm1Qd1lBVFhBaTNPd0VjcTQvODRKU2NPZDdpZW9RSXA0a3VHcDdkZzhONTZNQUdJRGFPdWVLN2dYR2tnaUh2b0UxRGxWdVR2bE5XSzF3UmlHVll4dkVUYy94ZTQ1ZHNRNlcxdFpteXd1emU4ZTRPdXN4Z3dyNEhYejJ0Q3Ard3hldW9rWVFjMWczS0p6QWdDUzBGUXEzamVJQ1VVdmhPaFdHTzAxTEg2Ym5SRWV2c1g1K0Nhb244YzNFQy81Z1czZ21qSjQrYXJYM3cySWU1U1IxdEZHN0xvVEwya05iamtOeXQ0aFRUV211emRiRjlibFMrQWJuQVorSFBnTzhLMWduLzFETHh5WkRyZUc3NFNjTldFOEx3aldybllsZi9MN1JCZkp0U0ZicG1vclVDSm5RYytWZmZHNDJQZ0kyaUo1NFJ1SzJtVVVINVdPdXByK2ovTVJmclUrbFpxdVZ4dWVjaXd4MWNOZnBIN0VrS1RZYWZOT1BjTzZxc3ZSOFluT0VKeHRmY2w0UEwwSWlqREVET05GS3E0WUtCaFZkVlRYVVRGbWRaMTVldTZZKzlGS3lmdStiaEt4VlUrblQrVGE2bkNEcUpFOHZNRVEvK25NRFlpdXlFL1NuU1pYL291UlZVZ2w1U1puREpZVFhMQW1IQ2FRNXpYcndOaVhITnJkN01BU3VGOHJ1TFdYWWdzYzc4NjlvMVQxeDlaamRnV0VseHJRbWl4NkZ5L0FSeG1CYi96MEpGZHFsTUVoTUtsYUUrb0ppM1RkVHhoeFVEaEVGMG40dkRObk03Y2JQQVoyZnA3WEpQNm5mWllHSE9PY1JXankydDNTQktpczZMMUxZRnlOZ08xK1gwcy9UMTk3WUxvdkpsalczeXFJMklqYWxhYTVidWhueE56L1ZrM2VseFlWczVBPT0iLCJkYXRha2V5IjoiQVFFQkFIaHdtMFlhSVNKZVJ0Sm01bjFHNnVxZWVrWHVvWFhQZTVVRmNlOVJxOC8xNHdBQUFINHdmQVlKS29aSWh2Y05BUWNHb0c4d2JRSUJBREJvQmdrcWhraUc5dzBCQndFd0hnWUpZSVpJQVdVREJBRXVNQkVFRFBSM1F5bVFvekNlS3JrWDJRSUJFSUE3MUxYam5TTmg3dTczTEdGcVpmeGZyRm1OaG1DUTZOblljNU1pNng0TUdZUHNXSlVkbGtRU0d0VlFqbUpWQm4xbFREeWEvZFpCUzlZUXNFQT0iLCJ2ZXJzaW9uIjoiMiIsInR5cGUiOiJEQVRBX0tFWSIsImV4cGlyYXRpb24iOjE1NDA5NjQwMzd9 -e none https://041444721655.dkr.ecr.us-east-1.amazonaws.com
docker push 041444721655.dkr.ecr.us-east-1.amazonaws.com/cg2-linux-asg/redis:latest


cp readme ../output/nb-redis/
cp -r conf ../output/nb-redis/

echo "---------------build ./nb-taskengine---------------"
cd ../nb-taskengine
docker image build -t cg2-linux-asg/task-engine -f Dockerfile .
docker tag cg2-linux-asg/task-engine:latest 041444721655.dkr.ecr.us-east-1.amazonaws.com/cg2-linux-asg/task-engine:latest
docker push 041444721655.dkr.ecr.us-east-1.amazonaws.com/cg2-linux-asg/task-engine:latest

cp readme ../output/nb-taskengine/
cp -r conf ../output/nb-taskengine/


cd ..
echo "---------------build completed. ---------------"
echo "you find image tar files in current directory"

