# AutoUpdateVersionInfos

Windows �f�X�N�g�b�v�A�v���̃o�[�W�����X�V�����������I�ɍs���@�\�T���v��

�O��̏o�͌��ʂ����ăo�[�W�����X�V�������Ȃ����߁A���r���h����ƃ��Z�b�g����Ă��܂��Ƃ������������邽�߁A���ǂ̗]�n�͂��邩���B

�T���v���Ƃ��āA�P���ɓ��t���o�[�W�����ɔ��f������́A��N���N�_�Ƃ��ăo�[�W������ݒ肷����́A�V���v����Revision���C���N�������g������̂̂R��ނ�p�ӁB

VS2022���Ȃ� pwsh ���قڂقڎg����͂��Ȃ̂ŁAPowerShell �̌Ăяo���́Apwsh �ł����Ȃ��B����ɂ��ACI/CD �Ȃǂł̃r���h���e�����o�Ȃ��B

## �ۑ�

CI/CD ���ȂǁA�O��̏o�͌��ʂ��Ȃ��ꍇ�ɁA�ȑO�̃o�[�W�������킩��Ȃ��Ƃ������ׂ�����B

�Ƃ͂����ACI/CD �őO�񌋉ʂ������p����悤�ɂ���ɂ͌ŗL�̊���`���K�v�ɂȂ邽�߁A���̃T���v���ł͎������Ȃ����̂Ƃ���B


## �v���p�e�B

- `NeedSdkFileVersion`:SDK�v���W�F�N�g�`���p�o�[�W�����o�͎w��
- `NeedCppFileVersion`:C/C++ ��.rc�捞�p�o�͎w��  
$(IntDir)$(ProjectName).VersionInfo.h �ɏo�͂����̂ŁA.rc �Ŏ����Ŏ�荞�ނ���
- `NeedNetfxFileVersion`:�]���^�̃v���W�F�N�g�`���p�o�[�W�����o�͎w��B  
�����I�Ƀv���W�F�N�g�ɒǉ�����̂ŁAAssemblyInfo.cs ����o�[�W������`(`AssemblyVersion`, `AssemblyFileVersion`)���폜���Ă����K�v������B
- `AutoUpdateVersionInfo`: `BuildDate`, `OffsetDate`, `SimpleIncrement` �̂R��ނ̏o�̓p�^�[���̂����ꂩ���w��
- `StartYear`: `OffsetDate` �̏ꍇ�A��N
- `FileVersion` or `Version`: ��ƂȂ�o�[�W������ݒ�BMajor.Minor �͍Œ���ݒ肷��K�v������BC++�ȊO�͂��̃o�[�W������`AssemblyVersion`�ɂȂ�B
