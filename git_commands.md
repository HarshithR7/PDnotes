

### ✅ Step-by-step to Push Your Project to GitHub

#### 1. **Initialize Git (if not already done)**

You may have already done this, but to be safe:

```bash
git init
```

---

#### 2. **Add a branch (use `main` as GitHub expects)**

```bash
git checkout -b main
```

---

#### 3. **Add all files**

```bash
git add .
```

---

#### 4. **Commit**

```bash
git commit -m "Initial commit"
```

---

### **Github account add**

```bash
 git config --global user.email "harshithreddy18@gmail.com"
 git config --global user.name "HarshithR7"

```
#### 5. **Add the remote**

(Only do this once)

```bash
git remote set-url origin https://github.com/HarshithR7/32_MIPS.git  // if already 

or
git remote add origin https://github.com/HarshithR7/32bit_mips_processor.git
```

---

#### 6. **Push to GitHub**

```bash
git push -u origin main
```


✅ Step-by-Step to Recover the Lost Work
🔍 1. Check the commit you made before the pull
```bash
git reflog
```
Look for a line like:
```bash
> abc1234 HEAD@{1}: commit: WIP: local changes before rebase
```
That abc1234 is the commit hash of your lost work. It’s still in your Git object database!

🔄 2. Recover that commit
To restore your lost files to your working directory, run:
```bash
git checkout abc1234
```
(Replace abc1234 with the actual hash you saw in reflog)

This will switch your working directory to that commit, and all your files should be back.

💾 3. Create a new branch to save the recovered state (highly recommended)
To avoid losing this again:
```bash
git checkout -b recovered-wip
```
Now you're on a safe branch with your recovered changes.

