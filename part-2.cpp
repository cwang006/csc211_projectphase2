#include <iostream>
using namespace std;

int DM[10000];

/**void fun1(int& reg0, int& reg1, int& reg2){
    if(reg0 < reg2){
        reg3 = 1;
    } else{
        reg3 = 0;
    }
}

void fun2(int& reg0, int& reg1, int& reg2){
    reg3 = (reg0 * reg1);
    reg4 = (reg2 * reg1);
    reg3 = reg3 + reg4;
}
****/

int main(){
    int reg0, reg1, reg2, reg3;
    int reg4 = 5000;
    int reg5 = 5004; 
    int reg6 = 5008;
    
    DM[reg4] = 1;
    DM[reg5] = 2;
    DM[reg6] = 4;

    
    reg0 = DM[reg4];
    reg1 = DM[reg5];
    reg2 = DM[reg6];
    
    cout << "Register 0: " << reg0 << endl;
    cout << "Register 1: " << reg1 << endl;
    cout << "Register 2: " << reg2 << endl;
    cout << "_______________________________\n";
    
    reg3 = reg0 + reg1;
    cout << "Completing: add $t3,$t0,$t1 \n";
    cout << "Register 3: " << reg3 << endl << endl;
    
    reg3 = reg3 + reg2;
    cout << "Completing: add $t3,$t3,$t2 \n";
    cout << "Register 3: " << reg3 << endl << endl;
    
    DM[5008] = reg3;
    cout << "Completing: sw $t3, 0($t4) \n";
    cout << DM[5008] << endl;
    
    
    reg6 = DM[5000];
    cout << "Completing: addi $t6,$zero,5000 \n";
    cout << "Register 6: " << reg6 << endl << endl;
    
    reg0 = DM[5000];
    cout << "Completing: sw $t3,0($t6) \n";
    cout << "Register 0: " << reg0 << endl << endl;
    
    return 0;
    
}
